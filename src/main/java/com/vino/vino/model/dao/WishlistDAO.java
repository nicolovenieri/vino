package com.vino.vino.model.dao;

import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.User;
import com.vino.vino.model.mo.Wine;
import com.vino.vino.model.mo.Wishlist;

import java.util.List;

public interface WishlistDAO {

    public Wishlist create(
            User user,
            Wine wine
    ) throws DuplicatedObjectException;

    public List<Wishlist> findWishlist(User user);

    public Wishlist remove(User user, Wine wine);
}
