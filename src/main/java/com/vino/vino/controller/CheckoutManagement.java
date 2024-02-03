package com.vino.vino.controller;

import com.vino.vino.model.dao.*;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.*;
import  com.vino.vino.services.config.Configuration;
import  com.vino.vino.services.logservice.LogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class CheckoutManagement {

    public static void view(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;
        String viewUrl = "checkoutManagement/view";
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

            cartRetrieve(daoFactory, sessionDAOFactory, request);

            List<Cart> carts = (List<Cart>) request.getAttribute("carts");
            for(int i = 0; i < carts.size(); i++) {
                if(carts.get(i).getQuantity() > carts.get(i).getWine().getAvalaibility()) {
                    applicationMessage = "Errore: la quantita' richiesta di " + carts.get(i).getWine().getName() + " eccede la quantita' disponibile in magazzino";
                    viewUrl = "cartManagement/view";
                }
            }

            UserDAO userDAO = daoFactory.getUserDAO();
            User user = userDAO.findByUserId(loggedUser.getUserId());

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("user", user);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", viewUrl);

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

    public static void order(HttpServletRequest request, HttpServletResponse response) {

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


            OrderDAO orderDAO = daoFactory.getOrderDAO();

            cartRetrieve(daoFactory, sessionDAOFactory, request);
            List<Cart> carts = (List<Cart>) request.getAttribute("carts");

            Long user_id = loggedUser.getUserId();
            UserDAO userDAO = daoFactory.getUserDAO();
            User current_user = userDAO.findByUserId(user_id);
            Date date = new Date();
            Timestamp ts = new Timestamp(date.getTime());

            long coupon_id;
            Coupon coupon = null;
            CouponDAO couponDAO = daoFactory.getCouponDAO();

            try {
                coupon_id = Long.parseLong(request.getParameter("coupon_id"));
                coupon = couponDAO.findByCouponId(coupon_id);

            } catch (NumberFormatException e) { }

            BigDecimal total_amount = (BigDecimal) request.getAttribute("total_amount");
            if (coupon!=null) {

                double discount = (double)coupon.getDiscount();
                discount = discount/100;
                total_amount = total_amount.subtract(total_amount.multiply(new BigDecimal(discount)));
            }

            String status = "Processamento ordine";

            PreferenceDAO preferenceDAO = daoFactory.getPreferenceDAO();
            WineDAO wineDAO = daoFactory.getWineDAO();

            for (int i = 0; i < carts.size(); i++) {

                long quantity = carts.get(i).getQuantity();

                //creo l'ordine
                orderDAO.create(
                        current_user,
                        carts.get(i).getWine(),
                        quantity,
                        status,
                        ts,
                        total_amount
                );

                //sottraggo dal db la quantita' di prodotti acquistati
                wineDAO.updateAvalaibility(carts.get(i).getWine().getWineId(), (int) quantity);

                //aggiorno le preferenze dell'utente
                Preference preference = preferenceDAO.findByUserCategory(user_id, carts.get(i).getWine().getCategory());

                if(preference == null) {
                    //se l'utente non ha ancora acquistato vini di una specifica tipologia, creo una tupla nella tabella
                    preferenceDAO.create(
                            current_user.getUserId(),
                            carts.get(i).getWine().getCategory(),
                            carts.get(i).getQuantity());
                } else {

                    //altrimenti aggiorno una tupla gia' esistente
                    preference.setTimes(preference.getTimes() + quantity);
                    preferenceDAO.update(preference);
                }
            }

            //svuoto il carrello
            User user = userDAO.findByUserId(loggedUser.getUserId());
            CartDAO cartDAO = daoFactory.getCartDAO();
            cartDAO.deleteCart(user);

            applicationMessage = "Ordine effettuato. tieni d'occhio gli ordini effettuati nell'area utente.";

            wineRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);
            preferencesRetrieve(daoFactory, sessionDAOFactory, request, user_id);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

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

    private static void wineRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        WineDAO WineDAO = daoFactory.getWineDAO();
        wines = WineDAO.findAll();
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

    private static void cartRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        UserDAO userDAO = daoFactory.getUserDAO();
        UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();

        User loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();

        User user = userDAO.findByUserId(loggedUser.getUserId());

        CartDAO cartDAO = daoFactory.getCartDAO();
        List<Cart> carts;
        carts = cartDAO.findCart(user);

        WineDAO wineDAO = daoFactory.getWineDAO();
        Wine wine = null;
        ArrayList<Wine> wines = new ArrayList<Wine>() ;

        BigDecimal total_amount = BigDecimal.ZERO;
        BigDecimal subtotal = BigDecimal.ZERO;
        BigDecimal shipping = BigDecimal.ZERO;

        int i=0;
        for (i = 0; i < carts.size(); i++) {
            wine=wineDAO.findByWineId(carts.get(i).getWine().getWineId());
            Long quantity = carts.get(i).getQuantity();
            wines.add(wine);
            subtotal = subtotal.add(wine.getPrice().multiply(new BigDecimal(quantity)));
            carts.get(i).setWine(wine);
        }

        total_amount = subtotal.multiply(new BigDecimal("1.05"));
        shipping = total_amount.subtract(subtotal);

        request.setAttribute("total_amount", total_amount);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("carts", carts);
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
