package com.vino.vino.model.dao;

import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Coupon;

import java.sql.Date;
import java.util.List;
public interface CouponDAO {

    public Coupon create(
            String name,
            Long discount,
            Date exp_date
    ) throws DuplicatedObjectException;

    public Coupon findByCouponId(Long CouponId);

    public Coupon SearchByCouponName(String CouponName);

    public List<Coupon> findAll();

    public void modify(Coupon coupon)  throws DuplicatedObjectException;

    public void delete(Coupon coupon);

}

