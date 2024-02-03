package com.vino.vino.services.config;

import com.vino.vino.model.dao.DAOFactory;

import java.util.Calendar;
import java.util.logging.Level;

//*****************************************************OCCHIO ALLA PASSWORD *****************************************************************
//*****************************************************OCCHIO ALLA PASSWORD *****************************************************************
//*****************************************************OCCHIO ALLA PASSWORD *****************************************************************
//*****************************************************OCCHIO ALLA PASSWORD *****************************************************************
//*****************************************************OCCHIO ALLA PASSWORD *****************************************************************


public class Configuration {

    /* Database Configruation */
    public static final String DAO_IMPL= DAOFactory.MYSQLJDBCIMPL;
    public static final String DATABASE_DRIVER="com.mysql.cj.jdbc.Driver";
    public static final String SERVER_TIMEZONE=Calendar.getInstance().getTimeZone().getID();
    public static final String DATABASE_URL="jdbc:mysql://localhost/brewbazar?user=root&password=4994&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone="+SERVER_TIMEZONE;
//    public static final String DATABASE_URL="jdbc:mysql://localhost:3306/brewbazar?user=root&password=riccardo08&useSSL=false&serverTimezone="+SERVER_TIMEZONE;


    /* Session Configuration */
    public static final String COOKIE_IMPL=DAOFactory.COOKIEIMPL;
    public static final String GLOBAL_LOGGER_NAME="BrewBazar.txt";
    public static final String GLOBAL_LOGGER_FILE= "C:\\Users\\vniko\\Documents\\CantinaMaster\\Cantina\\BrewBazarLog.txt";
//    public static final String GLOBAL_LOGGER_FILE= "/Users/matteo/Desktop/vino/log/Cantina.txt";
    public static final Level GLOBAL_LOGGER_LEVEL=Level.ALL;



}



