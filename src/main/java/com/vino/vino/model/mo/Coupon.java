package com.vino.vino.model.mo;

import java.util.Date;

public class Coupon {

    private Long coupon_id;
    private String name;
    private Long discount;
    private java.sql.Date exp_date;
    private boolean deleted;

    /* 1:N */
    private Order[] orders;



    public Long getCouponId() {
        return coupon_id;
    }

    public void setCouponId(Long coupon_id) {
        this.coupon_id = coupon_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getDiscount() {
        return discount;
    }

    public void setDiscount(Long discount) {
        this.discount = discount;
    }

    public java.sql.Date getExp_date() {
        return exp_date;
    }

    public void setExp_date(java.sql.Date exp_date) {
        this.exp_date = exp_date;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public Order[] getOrders() {
        return orders;
    }

    public void setOrders(Order[] orders) {
        this.orders = orders;
    }


}
