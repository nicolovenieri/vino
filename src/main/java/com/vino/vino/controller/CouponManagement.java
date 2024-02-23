package com.vino.vino.controller;

import com.vino.vino.model.dao.*;
import com.vino.vino.model.dao.CouponDAO;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.*;
import com.vino.vino.model.mo.Coupon;
import com.vino.vino.services.config.Configuration;
import com.vino.vino.services.logservice.LogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CouponManagement {

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

            couponRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/couponManagement");

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

    public static void insertView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory=null;
        User loggedUser;
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

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("viewUrl", "adminManagement/couponInsModView");

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

    public static void insert(HttpServletRequest request, HttpServletResponse response) {

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


            CouponDAO couponDAO = daoFactory.getCouponDAO();

            Long discount = Long.parseLong(request.getParameter("discount"));

            //costruzione della data
            String received_exp_date = (request.getParameter("exp_date"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date date = sdf.parse(received_exp_date);
            long millis = date.getTime();
            java.sql.Date exp_date = new java.sql.Date(millis);


            try {

                couponDAO.create(
                        request.getParameter("name"),
                        discount,
                        exp_date
                );

            } catch (DuplicatedObjectException e) {
                applicationMessage = "Coupon già esistente";
                logger.log(Level.INFO, "Tentativo di inserimento di vino già esistente");
            }

            couponRetrieve(daoFactory, sessionDAOFactory, request);
            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/couponManagement");

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

    public static void modifyView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory=null;
        DAOFactory daoFactory = null;
        User loggedUser;
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

            Long coupon_id = Long.parseLong(request.getParameter("coupon_id"));

            CouponDAO couponDAO = daoFactory.getCouponDAO();
            Coupon coupon = couponDAO.findByCouponId(coupon_id);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("coupon", coupon);
            request.setAttribute("viewUrl", "adminManagement/couponInsModView");

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

    public static void modify(HttpServletRequest request, HttpServletResponse response) {

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

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();


            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            Long coupon_id = Long.parseLong(request.getParameter("coupon_id"));

            CouponDAO couponDAO = daoFactory.getCouponDAO();
            Coupon coupon = couponDAO.findByCouponId(coupon_id);

            Long discount = Long.parseLong(request.getParameter("discount"));

            //costruzione della data
            String received_exp_date = (request.getParameter("exp_date"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date date = sdf.parse(received_exp_date);
            long millis = date.getTime();
            java.sql.Date exp_date = new java.sql.Date(millis);


            coupon.setName(request.getParameter("name"));
            coupon.setDiscount(discount);
            coupon.setExp_date(exp_date);

            try {
                couponDAO.modify(coupon);
            } catch (DuplicatedObjectException e) {
                applicationMessage = "Coupon già esistente";
                logger.log(Level.INFO, "Tentativo di inserimento di vino già esistente");
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            couponRetrieve(daoFactory, sessionDAOFactory, request);
            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/view");

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

    public static void delete(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
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

            Long coupon_id = Long.parseLong(request.getParameter("coupon_id"));

            CouponDAO couponDAO = daoFactory.getCouponDAO();
            Coupon coupon = couponDAO.findByCouponId(coupon_id);



            //faccio la delete e catcho la Null pointer exception che avviene nel
            //caso un utente aggiorni la pagina dopo aver cliccato sul pulsante cestino
            try{
                couponDAO.delete(coupon);
                couponRetrieve(daoFactory, sessionDAOFactory, request);
            }
            catch(NullPointerException e){
                couponRetrieve(daoFactory, sessionDAOFactory, request);
                request.setAttribute("viewUrl", "adminManagement/couponManagement");
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();
            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("viewUrl", "adminManagement/couponManagement");

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

    public static void Apply(HttpServletRequest request, HttpServletResponse response) {

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

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            UserDAO userDAO = daoFactory.getUserDAO();
            User user = userDAO.findByUserId(loggedUser.getUserId());

            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();

            cartRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            String coupon_name = new String(request.getParameter("coupon_name"));

            CouponDAO couponDAO = daoFactory.getCouponDAO();
            Coupon coupon = couponDAO.SearchByCouponName(coupon_name);
            if (coupon==null) {
                applicationMessage = "Coupon non trovato";
            }
            else{
                applicationMessage = "Coupon applicato correttamente";
                request.setAttribute("coupon", coupon);

                BigDecimal total_amount = (BigDecimal) request.getAttribute("total_amount");
                double discount = (double)coupon.getDiscount();
                discount = discount/100;
                BigDecimal total_discounted = total_amount.subtract(total_amount.multiply(new BigDecimal(discount)));
                request.setAttribute("total_discounted", total_discounted);
            }
            request.setAttribute("language",language);
            request.setAttribute("user", user);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "checkoutManagement/view");

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

    private static void couponRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        CouponDAO couponDAO = daoFactory.getCouponDAO();
        List<Coupon> coupons;
        coupons = couponDAO.findAll();
        request.setAttribute("coupons", coupons);
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

        //calcolo della spedizione
        total_amount = subtotal.multiply(new BigDecimal("1.10"));
        shipping = total_amount.subtract(subtotal);

        request.setAttribute("total_amount", total_amount);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("carts", carts);
    }
}

