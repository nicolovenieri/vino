package com.vino.vino.model.dao.mySQLJDBCImpl;


import com.vino.vino.model.dao.CartDAO;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Cart;
import com.vino.vino.model.mo.User;
import com.vino.vino.model.mo.Wine;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAOMySQLJDBCImpl implements CartDAO {
    Connection conn;

    public CartDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Cart create(
            User user,
            Wine wine, long quantity) throws DuplicatedObjectException {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setWine(wine);
        cart.setQuantity(quantity);

        //controllo se esiste gia' una tupla con wined_id e user_id
        try {

            String sql
                    = " SELECT * "
                    + " FROM cart "
                    + " WHERE "
                    + " deleted ='N' AND "
                    + " user_id = ? AND"
                    + " wine_id = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, cart.getUser().getUserId());
            ps.setLong(i++, cart.getWine().getWineId());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            Long oldquantity = null;
            Long existing_cart_id = null;
            exist = resultSet.next();
            if (exist){
                existing_cart_id = (resultSet.getLong("cart_id"));
                oldquantity = (resultSet.getLong("quantity"));
            }

            resultSet.close();

            if (exist) {
                try{
                    Long newquantity = oldquantity + 1;
                    sql
                            = " UPDATE cart "
                            + " SET "
                            + " quantity = ?"
                            + " WHERE "
                            + "   cart_id = ? ";

                    ps = conn.prepareStatement(sql);
                    i = 1;
                    ps.setLong(i++, newquantity);
                    ps.setLong(i++, existing_cart_id);

                    ps.executeUpdate();

                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }

                throw new DuplicatedObjectException("CartDAOJDBCImpl.create: Tentativo di creazione di un oggetto nel careello gia esistente");
            }
            sql
                    = " INSERT INTO cart "
                    + "     (user_id,"
                    + "     wine_id,"
                    + "     quantity,"
                    + "     deleted "
                    + "   ) "
                    + " VALUES (?,?,1,'N')";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, cart.getUser().getUserId());
            ps.setLong(i++, cart.getWine().getWineId());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return cart;

    }

    @Override
    public Cart remove(
            User user,
            Wine wine) {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setWine(wine);

        try {

            String sql
                    = " SELECT * "
                    + " FROM cart "
                    + " WHERE "
                    + " deleted ='N' AND "
                    + " user_id = ? AND"
                    + " wine_id = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, cart.getUser().getUserId());
            ps.setLong(i++, cart.getWine().getWineId());

            ResultSet resultSet = ps.executeQuery();
            resultSet.next();

            Long oldquantity = (resultSet.getLong("quantity"));
            Long existing_cart_id = (resultSet.getLong("cart_id"));

            resultSet.close();

            Long newquantity = oldquantity - 1;
            // se newquantity è = a 0 allora elimino la tupla, altrimenti la aggiorno

            if(newquantity==0) {

                //elimino la tupla , setto anche la quantità = 0
                sql
                        = " UPDATE cart "
                        + " SET "
                        + " deleted = 'Y', "
                        + " quantity = 0"
                        + " WHERE "
                        + "   cart_id = ? ";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, existing_cart_id);

                ps.executeUpdate();
            }

            //aggiorno la tupla con la nuova quantità
            sql
                    = " UPDATE cart "
                    + " SET "
                    + " quantity = ?"
                    + " WHERE "
                    + "   cart_id = ? ";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, newquantity);
            ps.setLong(i++, existing_cart_id);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return cart;
    }

    public Cart removeBlock(
            User user,
            Wine wine) {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setWine(wine);

        try {

            // recupero il cart_id
            String sql
                    = " SELECT * "
                    + " FROM cart "
                    + " WHERE "
                    + " deleted ='N' AND "
                    + " user_id = ? AND"
                    + " wine_id = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, cart.getUser().getUserId());
            ps.setLong(i++, cart.getWine().getWineId());

            ResultSet resultSet = ps.executeQuery();
            resultSet.next();

            Long existing_cart_id = (resultSet.getLong("cart_id"));

            resultSet.close();

            //elimino la tupla , setto anche la quantità = 0
            sql
                    = " UPDATE cart "
                    + " SET "
                    + " deleted = 'Y', "
                    + " quantity = 0"
                    + " WHERE "
                    + "   cart_id = ? ";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, existing_cart_id);

            ps.executeUpdate();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return cart;
    }

    @Override
    public List<Cart> findCart(User user) {

        PreparedStatement ps;
        Cart cart;
        ArrayList<Cart> carts = new ArrayList<Cart>();

        try {

            Long user_id = user.getUserId();
            String sql
                    = " SELECT *"
                    + " FROM cart"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " user_id = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                cart = read(resultSet);
                carts.add(cart);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return carts;
    }

    @Override
    public void deleteCart( User user ) {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);

        try {


            //elimino le tuple con user_id corretto, setto anche la quantità = 0
            String sql
                    = " UPDATE cart "
                    + " SET "
                    + " deleted = 'Y', "
                    + " quantity = 0"
                    + " WHERE "
                    + "   user_id = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user.getUserId());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    Cart read(ResultSet rs) {
        Cart cart = new Cart();
        User user = new User();
        cart.setUser(user);
        Wine wine = new Wine();
        cart.setWine(wine);

        try {
            cart.setCartId(rs.getLong("cart_id"));
        } catch (SQLException sqle) {
        }
        try {
            cart.getUser().setUserId(rs.getLong("user_id"));
        } catch (SQLException sqle) {
        }
        try {
            cart.getWine().setWineId(rs.getLong("wine_id"));
        } catch (SQLException sqle) {
        }
        try {
            cart.setQuantity(rs.getLong("quantity"));
        } catch (SQLException sqle) {
        }
        try {
            cart.setDeleted(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        return cart;
    }
}
