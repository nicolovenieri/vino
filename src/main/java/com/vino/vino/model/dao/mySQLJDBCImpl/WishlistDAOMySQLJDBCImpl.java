package com.vino.vino.model.dao.mySQLJDBCImpl;


import com.vino.vino.model.dao.WishlistDAO;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Cart;
import com.vino.vino.model.mo.Wishlist;
import com.vino.vino.model.mo.User;
import com.vino.vino.model.mo.Wine;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAOMySQLJDBCImpl implements WishlistDAO {

    //private final String COUNTER_ID = "wishlist_id";
    Connection conn;

    public WishlistDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Wishlist create(
            User user,
            Wine wine) throws DuplicatedObjectException {

        PreparedStatement ps;
        Wishlist wishlist = new Wishlist();
        wishlist.setUser(user);
        wishlist.setWine(wine);

        //provo a vedere se esite gia una tupla con wined_id, user_id
        try {

            String sql
                    = " SELECT * "
                    + " FROM wishlist "
                    + " WHERE "
                    + " user_id = ? AND"
                    + " wine_id = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, wishlist.getUser().getUserId());
            ps.setLong(i++, wishlist.getWine().getWineId());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_wishlist_id = null;
            exist = resultSet.next();

            // leggo deleted e wishlist_id solo se esiste, altrimento ricevo nullPointer Exception
            if (exist){
                deleted = resultSet.getString("deleted").equals("Y");   //verifica se deleted è Y
                retrived_wishlist_id = (resultSet.getLong("wishlist_id"));
            }

            resultSet.close();
            if (exist && !deleted) {
                throw new DuplicatedObjectException("WishlistDAOJDBCImpl.create: Tentativo di inserimento di un elemento di wishlist già esistente.");
            }

            // esiste ma è cancellato -> torna in wish
            if (exist && deleted){
                sql
                        = " UPDATE wishlist "
                        + " SET deleted = 'N' "
                        + " WHERE wishlist_id = ? ";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_wishlist_id);
                ps.executeUpdate();
            }
            else {  //non esiste --> LO CREO

 /*               sql = "update counter set counterValue=counterValue+1 where counterId='" + COUNTER_ID + "'";

                ps = conn.prepareStatement(sql);
                ps.executeUpdate();

                sql = "SELECT counterValue FROM counter where counterId='" + COUNTER_ID + "'";

                ps = conn.prepareStatement(sql);
                resultSet = ps.executeQuery();
                resultSet.next();

                wishlist.setWishlistId(resultSet.getLong("counterValue"));

                resultSet.close();

*/
                sql
                        = " INSERT INTO wishlist "
                //      = "     (wishlist_id,"
                        + "     (user_id,"
                        + "     wine_id,"
                        + "     deleted "
                        + "   ) "
                        + " VALUES (?,?,'N')";      //se reimplemento, ricontrolla

                ps = conn.prepareStatement(sql);
                i = 1;
                //ps.setLong(i++, wishlist.getWishlistId());
                ps.setLong(i++, wishlist.getUser().getUserId());
                ps.setLong(i++, wishlist.getWine().getWineId());

                ps.executeUpdate();
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return wishlist;
    }

    public Wishlist remove( User user, Wine wine) {

        PreparedStatement ps;
        Wishlist wishlist = new Wishlist();
        wishlist.setUser(user);
        wishlist.setWine(wine);

        try {

            // recupero il wishlist_id
            String sql
                    = " SELECT * "
                    + " FROM wishlist "
                    + " WHERE "
                    + " deleted ='N' AND "
                    + " user_id = ? AND"
                    + " wine_id = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, wishlist.getUser().getUserId());
            ps.setLong(i++, wishlist.getWine().getWineId());

            ResultSet resultSet = ps.executeQuery();
            resultSet.next();

            Long existing_wishlist_id = (resultSet.getLong("wishlist_id"));

            resultSet.close();

            sql
                    = " UPDATE wishlist "
                    + " SET "
                    + " deleted = 'Y' "
                    + " WHERE "
                    + "  wishlist_id = ? ";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, existing_wishlist_id);

            ps.executeUpdate();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return wishlist;
    }

    @Override
    public List<Wishlist> findWishlist(User user) {

        PreparedStatement ps;
        Wishlist wishlist;
        ArrayList<Wishlist> wishlist_tuples = new ArrayList<Wishlist>();

        try {

            Long user_id = user.getUserId();
            String sql
                    = " SELECT *"
                    + " FROM wishlist"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " user_id = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                wishlist = read(resultSet);
                wishlist_tuples.add(wishlist);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return wishlist_tuples;
    }

    Wishlist read(ResultSet rs) {
        Wishlist wishlist = new Wishlist();
        User user = new User();
        wishlist.setUser(user);
        Wine wine = new Wine();
        wishlist.setWine(wine);

        try {
            wishlist.setWishlistId(rs.getLong("wishlist_id"));
        } catch (SQLException sqle) {
        }
        try {
            wishlist.getUser().setUserId(rs.getLong("user_id"));
        } catch (SQLException sqle) {
        }
        try {
            wishlist.getWine().setWineId(rs.getLong("wine_id"));
        } catch (SQLException sqle) {
        }
        try {
            wishlist.setDeleted(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        return wishlist;
    }
}
