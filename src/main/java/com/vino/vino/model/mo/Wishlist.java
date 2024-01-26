package com.vino.vino.model.mo;
public class Wishlist {

    private Long wishlist_id;
    /* N:1 */
    private User user;
    private Wine wine;
    private boolean deleted;

    public Long getWishlistId() { return wishlist_id; }

    public void setWishlistId(Long wishlist_id) { this.wishlist_id = wishlist_id; }

    public User getUser() { return user; }

    public void setUser(User user) { this.user = user; }

    public Wine getWine() { return wine; }

    public void setWine(Wine wine) {this.wine = wine; }

    public boolean isDeleted() { return deleted; }

    public void setDeleted(boolean deleted) { this.deleted = deleted; }

}

