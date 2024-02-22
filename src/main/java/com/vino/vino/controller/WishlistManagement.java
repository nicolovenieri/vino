package com.vino.vino.controller;

import com.vino.vino.model.dao.*;
import com.vino.vino.model.mo.*;

import com.vino.vino.services.config.Configuration;
import com.vino.vino.services.logservice.LogService;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class    WishlistManagement {

    public static void view(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;
        Language language;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();
            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            wishlistRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "wishlistManagement/view");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Controller Error", e);
            try {
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
            }
            throw new RuntimeException(e);

        } finally {
            try {
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
            }
        }

    }

    public static void AddWine(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        User loggedUser;
        Language language;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();
            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();

            Long wine_id = Long.parseLong(request.getParameter("wine_id"));

            WineDAO wineDAO = daoFactory.getWineDAO();
            Wine wine = wineDAO.findByWineId(wine_id);

            UserDAO userDAO = daoFactory.getUserDAO();
            User user = userDAO.findByUserId(loggedUser.getUserId());

            WishlistDAO wishlistDAO = daoFactory.getWishlistDAO();
            try {

                wishlistDAO.create(
                        user,
                        wine);

            } catch (DuplicatedObjectException e) {
                applicationMessage = "Ce l' avevi già nella wishlist.. ne aggiungo un altro allora, vedi di non guidare dopo :)";
                logger.log(Level.INFO, "Tentativo di inserimento di un nuovo vino gia presente nella wishlist");
            }

            wineRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);

            Long user_id;
            try {
                user_id = loggedUser.getUserId();
            } catch (NullPointerException e) {
                user_id = null;
            }
            if(loggedUser != null) {
                preferencesRetrieve(daoFactory, sessionDAOFactory, request, user_id);
            }

            int arrayPos;
            try {
                arrayPos = Integer.parseInt(request.getParameter("arrayPos"));
            } catch(NumberFormatException e) {
                arrayPos = 0;
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("arrayPos", arrayPos);
            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "homeManagement/view");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Controller Error", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
            }
            throw new RuntimeException(e);

        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
            }
        }

    }

    public static void RemoveWine(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        User loggedUser;
        Language language;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();
            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();

            Long wine_id = Long.parseLong(request.getParameter("wine_id"));
            String viewUrl = new String(request.getParameter("viewUrl"));

            WineDAO wineDAO = daoFactory.getWineDAO();
            Wine wine = wineDAO.findByWineId(wine_id);

            UserDAO userDAO = daoFactory.getUserDAO();
            User user = userDAO.findByUserId(loggedUser.getUserId());

            //long wine_id = Long.parseLong(request.getParameter("wine_id"));
            WishlistDAO wishlistDAO = daoFactory.getWishlistDAO();

            //rimuovo
            wishlistDAO.remove(user, wine);


            wineRetrieve(daoFactory, sessionDAOFactory, request);
            wishlistRetrieve(daoFactory, sessionDAOFactory, request);

            wineRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            //request.setAttribute("viewUrl", "cartManagement/view");
            request.setAttribute("viewUrl", viewUrl);


        } catch (Exception e) {
            logger.log(Level.SEVERE, "Controller Error", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
            }
            throw new RuntimeException(e);

        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
            }
        }

    }

    private static void wishlistRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {


        UserDAO userDAO = daoFactory.getUserDAO();
        UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();

        User loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();

        User user = userDAO.findByUserId(loggedUser.getUserId());

        WishlistDAO wishlistDAO = daoFactory.getWishlistDAO();
        List<Wishlist> wishlist_tuples;
        wishlist_tuples = wishlistDAO.findWishlist(user);
        request.setAttribute("wishlist_tuples", wishlist_tuples);

        //test
        WineDAO wineDAO = daoFactory.getWineDAO();
        Wine wine = null;
        ArrayList<Wine> wines = new ArrayList<Wine>() ;

        int i=0;
        for (i = 0; i < wishlist_tuples.size(); i++) {
            wine=wineDAO.findByWineId(wishlist_tuples.get(i).getWine().getWineId());
            wines.add(wine);
            wishlist_tuples.get(i).setWine(wine);
        }
    }

    private static void showcaseWineRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        showcaseRetrieve(daoFactory, sessionDAOFactory, request);

        List<Wine> wines = new ArrayList<Wine>();

        try {
            List<Showcase> showcases = (List<Showcase>)request.getAttribute("showcases");
            WineDAO wineDAO = daoFactory.getWineDAO();
            Wine wine;

            for(int i = 0; i < showcases.size(); i++) {

                wine = wineDAO.findByWineId(showcases.get(i).getWineId());
                wines.add(wine);
            }
        } catch(Exception e) {  }

        if(!wines.isEmpty()) {
            request.setAttribute("showcase_wines", wines);
        }

    }

    private static void showcaseRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ShowcaseDAO showcaseDAO = daoFactory.getShowcaseDAO();
        List<Showcase> showcases;
        showcases = showcaseDAO.findAll();
        request.setAttribute("showcases", showcases);

    }

    private static void wineRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        wines = wineDAO.findAll();
        request.setAttribute("wines", wines);
    }

    private static void preferencesRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request, Long user_id) {

        List<Wine> wines = new ArrayList<Wine>();
        WineDAO wineDAO = daoFactory.getWineDAO();

        PreferenceDAO preferenceDAO = daoFactory.getPreferenceDAO();
        List<Preference> preferences = new ArrayList<Preference>();
        String[] categoryArray = {"Rosso", "Bianco", "Champagne", "Altro"};

        for (int k = 0; k < categoryArray.length; k++) {
            if(preferenceDAO.findByUserCategory(user_id, categoryArray[k]) != null) {
                preferences.add(preferenceDAO.findByUserCategory(user_id, categoryArray[k]));
            }
        }

        Long preferredCategoryCounter = 0L;
        String preferredCategory = null;

        for(int k = 0; k < preferences.size(); k++) {
            if(preferences.get(k).getTimes() > preferredCategoryCounter) {
                preferredCategoryCounter = preferences.get(k).getTimes();
                preferredCategory = preferences.get(k).getCategory();
            }
        }

        wines = wineDAO.filterByCategory(preferredCategory);
        Random rand = new Random();
        int upperbound = wines.size();
        List<Wine> preferred_wines = new ArrayList<Wine>();

        //metto nella request tre vini scelti casualmente dalla categoria preferita dell'utente

        for(int k = 0; k < 5 && preferred_wines.size()<upperbound; k++) {
            Wine randomItem = wines.get(rand.nextInt(upperbound));
            int z=0;
            while(preferred_wines.contains(randomItem) && preferred_wines.size()<upperbound) {
                randomItem = wines.get(rand.nextInt(upperbound));
                z++;
            }
            preferred_wines.add(randomItem);
        }
        request.setAttribute("preferred_wines", preferred_wines);
    }
}
