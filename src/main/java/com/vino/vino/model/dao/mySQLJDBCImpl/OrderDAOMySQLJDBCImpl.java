package com.vino.vino.model.dao.mySQLJDBCImpl;
import com.vino.vino.model.dao.OrderDAO;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Coupon;
import com.vino.vino.model.mo.User;
import com.vino.vino.model.mo.Wine;
import com.vino.vino.model.mo.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class OrderDAOMySQLJDBCImpl implements OrderDAO {

    //private final String COUNTER_ID = "order_id";
    Connection conn;

    public OrderDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Order create(
            User user,
            Wine wine,
            Long quantity,
            String status,
            Timestamp timestamp,
            BigDecimal total_amount
    ){

        PreparedStatement ps;
        Order order = new Order();
        order.setUser(user);
        order.setWine(wine);
        order.setQuantity(quantity);
        order.setStatus(status);
        order.setTimestamp(timestamp);
        order.setTotalAmount(total_amount);

        try {
/*
            String sql = "update counter set counterValue=counterValue+1 where counterId='" + COUNTER_ID + "'";

            ps = conn.prepareStatement(sql);
            ps.executeUpdate();

            sql = "SELECT counterValue FROM counter where counterId='" + COUNTER_ID + "'";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();
            resultSet.next();

            order.setOrderId(resultSet.getLong("counterValue"));
            resultSet.close();


 */
            String sql
                    = " INSERT INTO `order` "
//                  + "     (order_id,"
                    + "   ( user_id,"
                    + "     wine_id,"
                    + "     quantity,"
                    + "     status,"
                    + "     `timestamp`,"
                    + "     total_amount,"
                    + "     deleted "
                    + "   ) "
                    + " VALUES (?,?,?,?,?,?,'N')";  //se reimplemento, ricontrolla

            ps = conn.prepareStatement(sql);
            int i = 1;
            //ps.setLong(i++, order.getOrderId());
            ps.setLong(i++, order.getUser().getUserId());
            ps.setLong(i++, order.getWine().getWineId());
            ps.setLong(i++, order.getQuantity());
            ps.setString(i++, order.getStatus());
            ps.setTimestamp(i++, order.getTimestamp());
            ps.setBigDecimal(i++, order.getTotalAmount());

            ps.executeUpdate();
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return order;
    }

    @Override
    public List<Order> findOrders(User user) {

        PreparedStatement ps;
        Order order;
        ArrayList<Order> order_tuples = new ArrayList<Order>();

        try {

            Long user_id = user.getUserId();
            String sql
                    = " SELECT *"
                    + " FROM `order`"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " user_id = ? "
                    + " ORDER BY timestamp DESC ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return order_tuples;
    }

    @Override
    public List<Order> findBySingleOrder(User user, Timestamp timestamp) {

        PreparedStatement ps;
        Order order;
        ArrayList<Order> order_tuples = new ArrayList<Order>();

        try {

            Long user_id = user.getUserId();
            String sql
                    = " SELECT *"
                    + " FROM `order`"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " timestamp = ? AND"
                    + " user_id = ? ";

            ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, timestamp);
            ps.setLong(2, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return order_tuples;
    }

    @Override
    public void updateStatus(User user, Timestamp timestamp, String status) {

        PreparedStatement ps;
        Order order;
        ArrayList<Order> order_tuples = new ArrayList<Order>();

        try {

            Long user_id = user.getUserId();
            String sql
                    = " SELECT *"
                    + " FROM `order`"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " timestamp = ? AND"
                    + " user_id = ? ";

            ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, timestamp);
            ps.setLong(2, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();

            sql
                    = " UPDATE `order` "
                    + " SET "
                    + " status = ?"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " timestamp = ? AND"
                    + " user_id = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, status);
            ps.setTimestamp(i++, timestamp);
            ps.setLong(i++, user_id);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    Order read(ResultSet rs) {
        Order order = new Order();
        User user = new User();
        order.setUser(user);
        Wine wine = new Wine();
        order.setWine(wine);

        try {
            order.setOrderId(rs.getLong("order_id"));
        } catch (SQLException sqle) {
        }
        try {
            order.getUser().setUserId(rs.getLong("user_id"));
        } catch (SQLException sqle) {
        }
        try {
            order.getWine().setWineId(rs.getLong("wine_id"));
        } catch (SQLException sqle) {
        }
        try {
            order.setQuantity(rs.getLong("quantity"));
        } catch (SQLException sqle) {
        }
        try {
            order.setStatus(rs.getString("status"));
        } catch (SQLException sqle) {
        }
        try {
            order.setTimestamp(rs.getTimestamp("timestamp"));
        } catch (SQLException sqle) {
        }
        try {
            order.setTotalAmount(rs.getBigDecimal("total_amount"));
        } catch (SQLException sqle) {
        }
        try {
            order.setDeleted(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        return order;
    }
}