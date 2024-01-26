package com.vino.vino.model.mo;

public class Cart {

    private Long cart_id;
    /* N:1 */
    private User user;
    private Wine wine;
    private Long quantity;
    private boolean deleted;

    public Long getCartId() { return cart_id; }

    public void setCartId(Long cart_id) { this.cart_id = cart_id; }

    public User getUser() { return user; }

    public void setUser(User user) { this.user = user; }

    public Wine getWine() { return wine; }

    public void setWine(Wine wine) {this.wine = wine; }

    public Long getQuantity() { return quantity; }

    public void setQuantity(Long quantity) {this.quantity = quantity; }

    public boolean isDeleted() { return deleted; }

    public void setDeleted(boolean deleted) { this.deleted = deleted; }

}

