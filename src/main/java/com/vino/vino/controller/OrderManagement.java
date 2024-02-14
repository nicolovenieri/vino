package com.vino.vino.controller;

import com.vino.vino.model.dao.*;

import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.*;
import com.vino.vino.services.config.Configuration;
import com.vino.vino.services.logservice.LogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.util.Date;
import java.time.LocalDateTime;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class OrderManagement {

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

            orderRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();


            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "orderManagement/view");

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

    public static void orderView(HttpServletRequest request, HttpServletResponse response) {

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

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            singleOrderRetrieve(daoFactory, sessionDAOFactory, request);


            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "orderManagement/singleOrder");

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

    public static void setDelivered(HttpServletRequest request, HttpServletResponse response) {

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

            singleOrderRetrieve(daoFactory, sessionDAOFactory, request);
            String status = "Ordine consegnato";
            boolean setDeliveredSwitch = true;
            request.setAttribute("setDeliveredSwitch", setDeliveredSwitch);

            OrderDAO orderDAO = daoFactory.getOrderDAO();
            List<Order> order_tuples = (List<Order>)request.getAttribute("order_tuples");
            orderDAO.updateStatus(order_tuples.get(0).getUser(), order_tuples.get(0).getTimestamp(), status);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();


            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "orderManagement/view");

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

    private static void cartRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {


        UserDAO userDAO = daoFactory.getUserDAO();
        UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();

        User loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();

        User user = userDAO.findByUserId(loggedUser.getUserId());

        CartDAO cartDAO = daoFactory.getCartDAO();
        List<Cart> carts;
        carts = cartDAO.findCart(user);
        request.setAttribute("carts", carts);

        //test
        WineDAO wineDAO = daoFactory.getWineDAO();
        Wine wine = null;
        ArrayList<Wine> wines = new ArrayList<Wine>() ;

        int i=0;
        for (i = 0; i < carts.size(); i++) {
            wine=wineDAO.findByWineId(carts.get(i).getWine().getWineId());
            wines.add(wine);
            carts.get(i).setWine(wine);
        }

    }

    private static void wineRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        wines = wineDAO.findAll();
        request.setAttribute("wines", wines);
    }

    private static void singleOrderRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) throws ParseException {

        UserDAO userDAO = daoFactory.getUserDAO();
        UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();

        User loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();
        User user = userDAO.findByUserId(loggedUser.getUserId());

        Timestamp order_timestamp = new java.sql.Timestamp(Long.parseLong(request.getParameter("order_date")));

        OrderDAO orderDAO = daoFactory.getOrderDAO();
        List<Order> order_tuples;
        order_tuples = orderDAO.findBySingleOrder(user, order_timestamp);
        request.setAttribute("order_tuples", order_tuples);

        WineDAO wineDAO = daoFactory.getWineDAO();
        Wine wine = null;
        ArrayList<Wine> wines = new ArrayList<Wine>();

        int i = 0;
        for (i = 0; i < order_tuples.size(); i++) {
            wine = wineDAO.findByWineId(order_tuples.get(i).getWine().getWineId());
            wines.add(wine);
            order_tuples.get(i).setWine(wine);
        }
    }

    private static void orderRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {


        UserDAO userDAO = daoFactory.getUserDAO();
        UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();

        User loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();

        User user = userDAO.findByUserId(loggedUser.getUserId());

        OrderDAO orderDAO = daoFactory.getOrderDAO();
        List<Order> order_tuples;
        order_tuples = orderDAO.findOrders(user);

        WineDAO wineDAO = daoFactory.getWineDAO();
        Wine wine = null;
        ArrayList<Wine> wines = new ArrayList<Wine>() ;

        for (int i = 0; i < order_tuples.size(); i++) {
            wine=wineDAO.findByWineId(order_tuples.get(i).getWine().getWineId());
            wines.add(wine);
            order_tuples.get(i).setWine(wine);
        }

        request.setAttribute("order_tuples", order_tuples);
    }
}

