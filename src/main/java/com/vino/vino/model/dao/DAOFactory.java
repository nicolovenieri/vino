package com.vino.vino.model.dao;

import com.vino.vino.model.dao.CookieImpl.CookieDAOFactory;
import com.vino.vino.model.dao.mySQLJDBCImpl.MySQLJDBCDAOFactory;

import java.util.Map;

public abstract class DAOFactory {

    // List of DAO types supported by the factory
    public static final String MYSQLJDBCIMPL = "MySQLJDBCImpl";
    public static final String COOKIEIMPL= "CookieImpl";

    public abstract void beginTransaction();
    public abstract void commitTransaction();
    public abstract void rollbackTransaction();
    public abstract void closeTransaction();

    public abstract UserDAO getUserDAO();
    public abstract WineDAO getWineDAO();
    public abstract CartDAO getCartDAO();
    public abstract WishlistDAO getWishlistDAO();
    public abstract OrderDAO getOrderDAO();
    public abstract CouponDAO getCouponDAO();
    public abstract ShowcaseDAO getShowcaseDAO();
    public abstract PreferenceDAO getPreferenceDAO();

    public static DAOFactory getDAOFactory(String whichFactory, Map factoryParameters) {

        if (whichFactory.equals(MYSQLJDBCIMPL)) {
            return new MySQLJDBCDAOFactory(factoryParameters);
        } else if (whichFactory.equals(COOKIEIMPL)) {
            return new CookieDAOFactory(factoryParameters);
        } else {
            return null;
        }
    }
}
