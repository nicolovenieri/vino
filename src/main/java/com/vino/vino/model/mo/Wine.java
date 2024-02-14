package com.vino.vino.model.mo;

import java.math.BigDecimal;

public class Wine {

    private Long wine_id;
    private String name;
    private String product_image;
    private BigDecimal price;
    private String denominazione;
    private String annata;
    private int avalaibility;
    private String vitigni;
    private String provenance;
    private String format;
    private int alcool;
    private String category;
    private String description;
    private boolean deleted;

    /* 1:N */
    private Cart[] carts;

    public Long getWineId() {
        return wine_id;
    }

    public void setWineId(Long wine_id) {
        this.wine_id = wine_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProductImage() {
        return product_image;
    }

    public void setProductImage(String product_image) {
        this.product_image = product_image;
    }

    public BigDecimal getPrice() { return price; }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDenominazione() {
        return denominazione;
    }

    public void setDenominazione(String denominazione) {
        this.denominazione = denominazione;
    }

    public String getAnnata() {
        return annata;
    }

    public void setAnnata(String annata) {
        this.annata = annata;
    }

    public int getAvalaibility() { return avalaibility; }

    public void setAvalaibility(int avalaibility) { this.avalaibility = avalaibility;}

    public String getVitigni() {
        return vitigni;
    }

    public void setVitigni(String vitigni) {
        this.vitigni = vitigni;
    }

    public String getProvenance() {
        return provenance;
    }

    public void setProvenance(String provenance) {
        this.provenance = provenance;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public int getAlcool() {
        return alcool;
    }

    public void setAlcool(int alcool) {
        this.alcool = alcool;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public Cart[] getCarts() { return carts; }

    public void setCarts(Cart[] carts) {this.carts = carts; }

    public Cart getCarts(int index) { return this.carts[index]; }

    public void setCarts(int index, Cart carts) {this.carts[index] = carts; }
}

