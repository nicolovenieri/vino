package com.vino.vino.model.dao.mySQLJDBCImpl;

import com.vino.vino.model.dao.*;
import com.vino.vino.services.config.Configuration;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

public class MySQLJDBCDAOFactory extends DAOFactory {
    private Map factoryParameters;
    private Connection connection;
    public MySQLJDBCDAOFactory(Map factoryParameters) {
        this.factoryParameters=factoryParameters;
    }

    @Override
    public void beginTransaction() {

        try {
            Class.forName(Configuration.DATABASE_DRIVER);
            this.connection = DriverManager.getConnection(Configuration.DATABASE_URL);
            this.connection.setAutoCommit(false);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void commitTransaction() {
        try {
            this.connection.commit();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void rollbackTransaction() {

        try {
            this.connection.rollback();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void closeTransaction() {
        try {
            this.connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public UserDAO getUserDAO() {
        return new UserDAOMySQLJDBCImpl(connection);
    }

    @Override
    public WineDAO getWineDAO() {
        return new WineDAOMySQLJDBCImpl(connection);
    }

    @Override
    public CartDAO getCartDAO() { return new CartDAOMySQLJDBCImpl(connection); }

    @Override
    public WishlistDAO getWishlistDAO() { return new WishlistDAOMySQLJDBCImpl(connection); }

    @Override
    public OrderDAO getOrderDAO() { return new OrderDAOMySQLJDBCImpl(connection); }

    @Override
    public CouponDAO getCouponDAO() { return new CouponDAOMySQLJDBCImpl(connection); }

    @Override
    public ShowcaseDAO getShowcaseDAO() { return new ShowcaseDAOMySQLJDBCImpl(connection); }

    @Override
    public PreferenceDAO getPreferenceDAO() { return new PreferenceDAOMySQLJDBCImpl(connection); }

    @Override
    public LanguageDAO getLanguageDAO() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}