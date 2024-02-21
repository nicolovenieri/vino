package com.vino.vino.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.vino.vino.model.mo.Language;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;
import com.vino.vino.services.config.Configuration;
import com.vino.vino.services.logservice.LogService;

import com.vino.vino.model.mo.User;
import com.vino.vino.model.mo.Wine;
import com.vino.vino.model.dao.DAOFactory;
import com.vino.vino.model.dao.LanguageDAO;
import com.vino.vino.model.dao.UserDAO;
import com.vino.vino.model.dao.WineDAO;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.dao.exception.DataTruncationException;
import java.math.BigDecimal;

public class WineManagement {

    private WineManagement() { }


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

            List<Wine> wines = wineRetrieve(daoFactory, sessionDAOFactory, request);

            int maxViewSize;
            if(wines.size() < 8) {
                maxViewSize = wines.size();
            } else{
                maxViewSize = 8;
            }
            try {
                maxViewSize = Integer.parseInt(request.getParameter("maxViewSize"));
            } catch(NumberFormatException | NullPointerException e) { }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("maxViewSize", maxViewSize);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/wineManagement");

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
            request.setAttribute("viewUrl", "adminManagement/wineInsModView");

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

            WineDAO wineDAO = daoFactory.getWineDAO();

            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int avalaibility = Integer.parseInt(request.getParameter("avalaibility"));
            Float alcool = Float.parseFloat(request.getParameter("alcool"));

            String photo = request.getParameter("product_image");
            //se la foto non è inserita metto di deafault questa
            if(photo.isEmpty()){
                photo = "https://montagnolirino.it/wp-content/uploads/2015/12/immagine-non-disponibile.png";
            }

            //se la denominazione non è inserita metto di default questa
            String den = request.getParameter("denominazione");
            if (den.isEmpty()){
                den = "---";
            }

            //se l'annata non è inserita metto di default questa
            String ann = request.getParameter("annata");
            if (ann.isEmpty()){
                ann = "---";
            }

            try {

                wineDAO.create(
                        request.getParameter("name"),
                        //request.getParameter("product_image"),
                        photo,
                        price,
                        //request.getParameter("denominazione"),
                        //request.getParameter("annata"),
                        den,
                        ann,
                        avalaibility,
                        request.getParameter("vitigni"),
                        request.getParameter("provenance"),
                        request.getParameter("format"),
                        alcool,
                        request.getParameter("category"),
                        request.getParameter("description")
                );

            } catch (DuplicatedObjectException e) {
                applicationMessage = "Vino già esistente";
                logger.log(Level.INFO, "Tentativo di inserimento di vino già esistente");
            } catch (DataTruncationException e) {
                applicationMessage = "importo massimo consentito: sei cifre intere e due decimali.";
            }

            wineRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/wineManagement");

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

            Long wine_id = Long.parseLong(request.getParameter("wine_id"));

            WineDAO wineDAO = daoFactory.getWineDAO();
            Wine wine = wineDAO.findByWineId(wine_id);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("wine", wine);
            request.setAttribute("viewUrl", "adminManagement/wineInsModView");

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

            Long wine_id = Long.parseLong(request.getParameter("wine_id"));

            WineDAO wineDAO = daoFactory.getWineDAO();
            Wine wine = wineDAO.findByWineId(wine_id);

            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int avalaibility = Integer.parseInt(request.getParameter("avalaibility"));
            Float alcool = Float.parseFloat(request.getParameter("alcool"));

            wine.setName(request.getParameter("name"));
            wine.setProductImage(request.getParameter("product_image"));
            wine.setPrice(price);
            wine.setDenominazione(request.getParameter("denominazione"));
            wine.setAnnata(request.getParameter("annata"));
            wine.setAvalaibility(avalaibility);
            wine.setVitigni(request.getParameter("vitigni"));
            wine.setProvenance(request.getParameter("provenance"));
            wine.setFormat(request.getParameter("format"));
            wine.setAlcool(alcool);
            wine.setCategory(request.getParameter("category"));
            wine.setDescription(request.getParameter("description"));

            try {
                wineDAO.modify(wine);
                applicationMessage = "Modifica avvenuta correttamente";
            } catch (DuplicatedObjectException e) {
                applicationMessage = "Vino già esistente";
                logger.log(Level.INFO, "Tentativo di inserimento di vino già esistente");
            } catch (DataTruncationException e) {
                applicationMessage = "Errore nella modifica del prezzo: importo massimo consentito: sei cifre intere e due decimali.";
                logger.log(Level.INFO, "Importo massimo consentito: sei cifre intere e due decimali.");
            }

            wineRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            wineRetrieve(daoFactory, sessionDAOFactory, request);

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/wineManagement");

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

            Long wine_id = Long.parseLong(request.getParameter("wine_id"));

            WineDAO wineDAO = daoFactory.getWineDAO();
            Wine wine = wineDAO.findByWineId(wine_id);

            //faccio la delete e catcho la Null pointer exception che avviene nel
            //caso un utente aggiorni la pagina dopo aver cliccato sul pulsante cestino
            try{
                wineDAO.delete(wine);
            }
            catch(NullPointerException e){
                request.setAttribute("viewUrl", "adminManagement/view");
            }

            wineRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("viewUrl", "adminManagement/wineManagement");

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

    public static void searchView(HttpServletRequest request, HttpServletResponse response) {

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

            wineSearch(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("viewUrl", "adminManagement/wineManagement");

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

    private static List<Wine> wineRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        wines = wineDAO.findAll();
        request.setAttribute("wines", wines);
        return wines;

    }

    private static void categoryRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        wines = wineDAO.filterByCategory(request.getParameter("category"));
        request.setAttribute("wines", wines);

    }

    private static void wineSearch(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        wines = wineDAO.findByName(request.getParameter("searchString"));
        request.setAttribute("wines", wines);
    }

}

