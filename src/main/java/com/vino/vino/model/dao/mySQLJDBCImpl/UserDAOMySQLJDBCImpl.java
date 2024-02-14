package com.vino.vino.model.dao.mySQLJDBCImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;
import com.vino.vino.model.dao.exception.DataTruncationException;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Cart;
import com.vino.vino.model.mo.User;
import com.vino.vino.model.dao.UserDAO;
import com.vino.vino.model.mo.Wine;


public class UserDAOMySQLJDBCImpl implements UserDAO {

    // private final String COUNTER_ID = "user_id";
    Connection conn;

    public UserDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public User create(
            Long user_id,
            String username,
            String password,
            String email,
            String name,
            String surname,
            Long phone,
            String city,
            Long cap,
            String street,
            String civic,
            Long card_n,
            Long cvc,
            String exp_date,
            boolean admin) throws DuplicatedObjectException, MysqlDataTruncation{

        PreparedStatement ps;
        User user = new User();
        //user.setUserId(createUserId());
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setName(name);
        user.setSurname(surname);


        try {
            //controllo se USERNAME esiste già in una tupla
            String sql
                    = " SELECT * "
                    + " FROM user "
                    + " WHERE "
                    + " username = ?";

                    ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, user.getUsername());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;

            exist = resultSet.next();
            //se esiste
            if (exist) {
                deleted = resultSet.getString("username").equals(user.getUsername());
            }

            resultSet.close();
            if(exist && deleted) {
                throw new DuplicatedObjectException("UserDAOJDBCImpl.create: Tentativo di inserimento di un username già esistente.");
            }
                else {
                sql
                        = " INSERT INTO user "
//                      + "     (user_id,"
                        + "     (username,"
                        + "     password,"
                        + "     email,"
                        + "     name,"
                        + "     surname,"
                        + "     phone,"
                        + "     city,"
                        + "     cap,"
                        + "     street,"
                        + "     civic,"
                        + "     card_n,"
                        + "     cvc,"
                        + "     exp_date,"
                        + "     admin,"
                        + "     deleted "
                        + "   ) "
                        + " VALUES (?,?,?,?,?,null,null,null,null,null,null,null,null,'N','N')";    //se reimplemento, ricontrolla

                    ps = conn.prepareStatement(sql);
                    i = 1;
                    //ps.setLong(i++, user.getUserId());
                    ps.setString(i++, user.getUsername());
                    ps.setString(i++, user.getPassword());
                    ps.setString(i++, user.getEmail());
                    ps.setString(i++, user.getName());
                    ps.setString(i++, user.getSurname());

                    ps.executeUpdate();

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    @Override
    public void update(User user) throws DuplicatedObjectException {

        PreparedStatement ps;
        String sql;
        try {
            // controllo solo sull'username, il resto non mi interessa
            // controllo se l'username (modificato) è già presente in una tupla
            sql
                    = " SELECT COUNT(*)username "
                    + " FROM user "
                    + " WHERE "
                    + " user_id != ? AND "
                    + " username = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user.getUserId());
            ps.setString(i++, user.getUsername());

            ResultSet resultSet = ps.executeQuery();
            int count = 0;

            if(resultSet.next()){
                count = resultSet.getInt(1);
            }

            resultSet.close();
            if(count != 0) {
                throw new DuplicatedObjectException("UserDAOJDBCImpl.create: Tentativo di inserimento di un username già esistente.");
            }
            else {
                //se non esiste prosegui con modifica
                sql
                        = " UPDATE user "
                        + " SET "
                        + " username = ? ,"
                        + " password = ? ,"
                        + " email = ? ,"
                        + " name = ? , "
                        + " surname = ? , "
                        + " phone = ? , "
                        + " city = ? , "
                        + " cap = ? , "
                        + " street = ? , "
                        + " civic = ? , "
                        + " card_n = ? , "
                        + " cvc = ? , "
                        + " exp_date = ? "
                        + " WHERE "
                        + " user_id = ?";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setString(i++, user.getUsername());
                ps.setString(i++, user.getPassword());
                ps.setString(i++, user.getEmail());
                ps.setString(i++, user.getName());
                ps.setString(i++, user.getSurname());
                ps.setLong(i++, user.getPhone());
                ps.setString(i++, user.getCity());
                ps.setLong(i++, user.getCap());
                ps.setString(i++, user.getStreet());
                ps.setString(i++, user.getCivic());
                ps.setLong(i++, user.getCard_n());
                ps.setLong(i++, user.getCvc());
                ps.setString(i++, user.getExp_date());
                ps.setLong(i++, user.getUserId());

                ps.executeUpdate();

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public User findLoggedUser() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public User findByUserId(Long user_id) {

        PreparedStatement ps;
        User user = null;

        try {

            String sql
                    = " SELECT * "
                    + " FROM user "
                    + " WHERE "
                    + " user_id = ? AND "
                    + "deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user_id);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                user = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    @Override
    public User findByUsername(String username) {

        PreparedStatement ps;
        User user = null;

        try {

            String sql
                    = " SELECT * "
                    + "   FROM user "
                    + " WHERE "
                    + "   username = ? AND "
                    + "deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                user = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    @Override
    public List<User> searchByUsername(String username) {

        PreparedStatement ps;
        User user;
        ArrayList<User> users = new ArrayList<User>();

        try {

            String sql
                    = "SELECT * "
                    + "FROM user "
                    + "WHERE "
                    + "username=? AND "
                    + "deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                user = read(resultSet);
                users.add(user);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return users;
    }

    @Override
    public List<User> findAll() {

        PreparedStatement ps;
        User user;
        ArrayList<User> users = new ArrayList<User>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM user"
                    + " WHERE "
                    + " deleted ='N'";

            ps = conn.prepareStatement(sql);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                user = read(resultSet);
                users.add(user);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }

    @Override
    public void setAdminStatusOn(User user) {

        PreparedStatement ps;
        try {

            String sql
                    = " UPDATE user "
                    + " SET admin='Y' "
                    + " WHERE "
                    + " user_id=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user.getUserId());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void setAdminStatusOff(User user) {

        PreparedStatement ps;
        try {

            String sql
                    = " UPDATE user "
                    + " SET admin='N' "
                    + " WHERE "
                    + " user_id=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user.getUserId());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(User user) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE user "
                    + " SET deleted='Y' "
                    + " WHERE "
                    + " user_id=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user.getUserId());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
/*
    Long createUserId() {

        long user_id;

        try {

            String sql = "update counter set counterValue=counterValue+1 where counterId='" + COUNTER_ID + "'";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.executeUpdate();

            sql = "SELECT counterValue FROM counter where counterId='" + COUNTER_ID + "'";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();
            resultSet.next();

            user_id = resultSet.getLong("counterValue");

            resultSet.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user_id;
    }
*/

    User read(ResultSet rs) {

        User user = new User();
        try {
            user.setUserId(rs.getLong("user_id"));
        } catch (SQLException sqle) {
        }
        try {
            user.setUsername(rs.getString("username"));
        } catch (SQLException sqle) {
        }
        try {
            user.setPassword(rs.getString("password"));
        } catch (SQLException sqle) {
        }
        try {
            user.setEmail(rs.getString("email"));
        } catch (SQLException sqle) {
        }
        try {
            user.setName(rs.getString("name"));
        } catch (SQLException sqle) {
        }
        try {
            user.setSurname(rs.getString("surname"));
        } catch (SQLException sqle) {
        }
        try {
            user.setPhone(rs.getLong("phone"));
        } catch (SQLException sqle) {
        }
        try {
            user.setCity(rs.getString("city"));
        } catch (SQLException sqle) {
        }
        try {
            user.setCap(rs.getLong("cap"));
        } catch (SQLException sqle) {
        }
        try {
            user.setStreet(rs.getString("street"));
        } catch (SQLException sqle) {
        }
        try {
            user.setCivic(rs.getString("civic"));
        } catch (SQLException sqle) {
        }
        try {
            user.setCard_n(rs.getLong("card_n"));
        } catch (SQLException sqle) {
        }
        try {
            user.setCvc(rs.getLong("cvc"));
        } catch (SQLException sqle) {
        }
        try {
            user.setExp_date(rs.getString("exp_date"));
        } catch (SQLException sqle) {
        }
        try {
            user.setDeleted(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        try {
            user.setAdmin(rs.getString("admin").equals("Y"));
        } catch (SQLException sqle) {
        }
        return user;
    }
}

