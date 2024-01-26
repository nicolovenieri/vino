package com.vino.vino.model.dao;

import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Cart;
import com.vino.vino.model.mo.User;
import com.vino.vino.model.mo.Wine;

import java.util.List;

public interface CartDAO {

    public Cart create(
            User user,
            Wine wine,
            long quantity
    ) throws DuplicatedObjectException;

    public List<Cart> findCart(User user);

    public Cart remove(User user, Wine wine);

    public Cart removeBlock(User user, Wine wine);

    public void deleteCart(User user);
}

