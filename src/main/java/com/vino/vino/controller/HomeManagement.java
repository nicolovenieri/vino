package com.vino.vino.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;
import com.vino.vino.model.dao.exception.DataTruncationException;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;


import com.vino.vino.model.dao.*;
import com.vino.vino.model.mo.*;
import com.vino.vino.services.config.Configuration;
import com.vino.vino.services.logservice.LogService;
import java.util.Random;

import com.vino.vino.model.dao.exception.DuplicatedObjectException;

public class HomeManagement {

    private HomeManagement() {
    }
    public static void temp(HttpServletRequest request, HttpServletResponse response){
        DAOFactory sessionDAOFactory= null;
        User loggedUser;
        Logger logger = LogService.getApplicationLogger();


        try {
            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            sessionDAOFactory.commitTransaction();

            //List<Prodotto> prodotti = ListaProdotti(daoFactory, sessionDAOFactory, request);
            request.setAttribute("viewUrl", "HomeManagement/view");
        }catch (Exception e) {

            try {logger.log(Level.SEVERE, "Controller Error", e);
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
    public static void view(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser = null;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            wineRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);

            List<Order> orders = new ArrayList<Order>();
            if(loggedUser != null && !loggedUser.isAdmin()) {
                OrderDAO orderDAO = daoFactory.getOrderDAO();
                orders = orderDAO.findOrders(loggedUser);
            }

            if(loggedUser != null && !loggedUser.isAdmin() && !orders.isEmpty()) {
                try {
                    long user_id = loggedUser.getUserId();
                    preferencesRetrieve(daoFactory, sessionDAOFactory, request, user_id);

                } catch (NullPointerException e) {
                    logger.log(Level.SEVERE, "Controller Error (user_id)", e);
                }
            }

            int arrayPos;
            try {
                if(request.getParameter("arrayPos") != null) {
                    arrayPos = Integer.parseInt(request.getParameter("arrayPos"));
                    request.setAttribute("arrayPos", arrayPos);
                }
            } catch(NumberFormatException | NullPointerException e) {
                logger.log(Level.SEVERE, "Controller Error (arrayPos)", e);
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "homeManagement/view");

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

    public static void changePage(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser = null;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            wineRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);

            List<Order> orders = new ArrayList<Order>();
            if(loggedUser != null && !loggedUser.isAdmin()) {
                OrderDAO orderDAO = daoFactory.getOrderDAO();
                orders = orderDAO.findOrders(loggedUser);
            }

            if(loggedUser != null && !loggedUser.isAdmin() && !orders.isEmpty()) {
                preferencesRetrieve(daoFactory, sessionDAOFactory, request, loggedUser.getUserId());
            }

            int arrayPos;
            try {
                arrayPos = Integer.parseInt(request.getParameter("arrayPos"));
            } catch(NumberFormatException | NullPointerException e) {
                arrayPos = 0;
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("arrayPos", arrayPos);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "homeManagement/view");

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

    public static void productView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            Long wine_id = Long.parseLong(request.getParameter("wine_id"));
            WineDAO WineDAO = daoFactory.getWineDAO();
            Wine wine = WineDAO.findByWineId(wine_id);

            List<Order> orders = new ArrayList<Order>();
            if(loggedUser != null && !loggedUser.isAdmin()) {
                OrderDAO orderDAO = daoFactory.getOrderDAO();
                orders = orderDAO.findOrders(loggedUser);
            }

            if(loggedUser != null && !loggedUser.isAdmin() && !orders.isEmpty()) {
                preferencesRetrieve(daoFactory, sessionDAOFactory, request, loggedUser.getUserId());
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("wine", wine);
            request.setAttribute("viewUrl", "homeManagement/productView");

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

    public static void loginView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory=null;
        User loggedUser;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("viewUrl", "homeManagement/loginView");

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

    public static void login(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters = new HashMap<String, Object>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            UserDAO userDAO = daoFactory.getUserDAO();
            User user = userDAO.findByUsername(username);

            if (user == null || !user.getPassword().equals(password) || user.isDeleted() == true) {
                sessionUserDAO.delete(null);
                applicationMessage = "Username o password errati!";
                loggedUser = null;
                wineRetrieve(daoFactory, sessionDAOFactory, request);
                showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);
                request.setAttribute("viewUrl", "homeManagement/loginView");
            } else {
                loggedUser = sessionUserDAO.create(user.getUserId(), null, null, null, user.getName(), user.getSurname(), null, null, null, null, null, null, null, null, user.isAdmin());

                if (user != null && user.isAdmin()) {
                    request.setAttribute("viewUrl", "adminManagement/view");

                } else {
                    request.setAttribute("viewUrl", "homeManagement/view");
                    wineRetrieve(daoFactory, sessionDAOFactory, request);
                    showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);

                    OrderDAO orderDAO = daoFactory.getOrderDAO();
                    List<Order> orders = new ArrayList<Order>(orderDAO.findOrders(loggedUser));

                    if(loggedUser != null && !loggedUser.isAdmin() && !orders.isEmpty()) {
                        preferencesRetrieve(daoFactory, sessionDAOFactory, request, loggedUser.getUserId());
                    }
                }
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn", loggedUser != null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);

        } catch(Exception e){
            logger.log(Level.SEVERE, "Controller Error", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
            }
            throw new RuntimeException(e);

        } finally{
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
            }
        }
    }

    public static void registerView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory=null;
        User loggedUser;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();


            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("viewUrl", "homeManagement/registerView");

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

    public static void register(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

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

            UserDAO userDAO = daoFactory.getUserDAO();
            User user;

            try {

                user = userDAO.create(
                        null,
                        request.getParameter("username"),
                        request.getParameter("password"),
                        request.getParameter("email"),
                        request.getParameter("name"),
                        request.getParameter("surname"),
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        false);

                applicationMessage = "Registrazione avvenuta con successo. Clicca su Login per effettuare l'accesso";
                request.setAttribute("viewUrl", "homeManagement/view");


            } catch (DuplicatedObjectException e) {
                applicationMessage = "Username già in uso.";
                logger.log(Level.INFO,"Tentativo di inserimento di un username già esistente.");
                request.setAttribute("viewUrl", "homeManagement/registerView");
            } catch (Exception e){
                applicationMessage = "Username troppo lungo - MAX 12 CARATTERI.";
                logger.log(Level.INFO,"Tentativo di inserimento di un username già esistente.");
                request.setAttribute("viewUrl", "homeManagement/registerView");
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);

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

    public static void logout(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            sessionUserDAO.delete(null);
            applicationMessage = "Logout effettuato con successo";

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            wineRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",false);
            request.setAttribute("loggedUser", null);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "homeManagement/view");

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

    public static void searchView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            wineSearch(daoFactory, sessionDAOFactory, request);

            if(loggedUser != null && !loggedUser.isAdmin()) {
                try {
                    long user_id = loggedUser.getUserId();
                    preferencesRetrieve(daoFactory, sessionDAOFactory, request, user_id);

                } catch (NullPointerException e) {
                    logger.log(Level.SEVERE, "Controller Error (user_id)", e);
                }
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("searchMode", true);
            request.setAttribute("searchedItem", request.getParameter("searchString"));
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("viewUrl", "homeManagement/view");

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

    public static void categoryView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            categoryRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "homeManagement/categoryView");

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

    public static void showcaseView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);

            List<Wine> wines = new ArrayList<Wine>();

            try {
                List<Showcase> showcases = (List<Showcase>)request.getAttribute("showcases");
                WineDAO wineDAO = daoFactory.getWineDAO();
                Wine wine;

                for(int i = 0; i < showcases.size(); i++) {

                    wine = wineDAO.findByWineId(showcases.get(i).getWineId());
                    wines.add(wine);
                }
            } catch(Exception e) {
                logger.log(Level.SEVERE, "Controller Error", e);
                applicationMessage = "Error: " + e;
            }

            Long user_id;
            try {
                user_id = loggedUser.getUserId();
            } catch (NullPointerException e) {
                user_id = null;
            }
            if(loggedUser != null) {
                preferencesRetrieve(daoFactory, sessionDAOFactory, request, user_id);
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("showcaseMode", true);
            request.setAttribute("wines", wines);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "homeManagement/view");

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

    private static void wineRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        wines = wineDAO.findAll();
        request.setAttribute("wines", wines);
    }

    private static void showcaseRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ShowcaseDAO showcaseDAO = daoFactory.getShowcaseDAO();
        List<Showcase> showcases;
        showcases = showcaseDAO.findAll();
        request.setAttribute("showcases", showcases);

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

    private static void wineSearch(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        wines = wineDAO.findByName(request.getParameter("searchString"));
        request.setAttribute("wines", wines);
    }

    private static void preferencesRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request, Long user_id) {

        List<Wine> wines = new ArrayList<Wine>();
        WineDAO wineDAO = daoFactory.getWineDAO();

        PreferenceDAO preferenceDAO = daoFactory.getPreferenceDAO();
        List<Preference> preferences = new ArrayList<Preference>();
        String[] categoryArray = {"Rosso", "Bianco", "Spumante", "Altro"};

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
            while(preferred_wines.contains(randomItem) && preferred_wines.size()<upperbound) {
                randomItem = wines.get(rand.nextInt(upperbound));
            }
            preferred_wines.add(randomItem);
        }
        request.setAttribute("preferred_wines", preferred_wines);
    }

    private static void categoryRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        wines = wineDAO.filterByCategory(request.getParameter("category"));
        request.setAttribute("wines", wines);

    }
}