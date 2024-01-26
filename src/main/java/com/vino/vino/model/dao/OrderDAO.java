package com.vino.vino.model.dao;

import com.vino.vino.model.mo.Order;
import com.vino.vino.model.mo.User;
import com.vino.vino.model.mo.Wine;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public interface OrderDAO {

    public Order create(
            User user,
            Wine wine,
            Long quantity,
            String status,
            Timestamp timestamp,
            BigDecimal total_amount
    );

    public List<Order> findOrders(User user);

    public List<Order> findBySingleOrder(User user, Timestamp timestamp);

    public void updateStatus(User user, Timestamp timestamp, String status);
}

