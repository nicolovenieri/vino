package com.vino.vino.model.mo;

public class User {
    private Long user_id;
    private String username;
    private String password;
    private String email;
    private String name;
    private String surname;
    private Long phone;
    private String city;
    private Long cap;
    private String street;
    private String civic;
    private Long card_n;
    private Long cvc;
    private String exp_date;
    private boolean deleted;
    private boolean admin;

    /* 1:N */
    private Cart[] carts;

    public Long getUserId() {return user_id; }

    public void setUserId(Long user_id) {this.user_id = user_id; }

    public String getUsername() {return username; }

    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }

    public void setPassword(String password) { this.password = password; }

    public String getEmail() {return email; }

    public void setEmail(String email) { this.email = email; }

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }

    public String getSurname() { return surname; }

    public void setSurname(String surname) { this.surname = surname; }

    public Long getPhone() { return phone; }

    public void setPhone(Long phone) { this.phone = phone; }

    public String getCity() { return city; }

    public void setCity(String city) { this.city = city; }

    public Long getCap() { return cap; }

    public void setCap(Long cap) { this.cap = cap; }

    public String getStreet() { return street; }

    public void setStreet(String street) { this.street = street; }

    public String getCivic() { return civic; }

    public void setCivic(String civic) {this.civic = civic;}

    public Long getCard_n() { return card_n; }

    public void setCard_n(Long card_n) { this.card_n = card_n;  }

    public Long getCvc() { return cvc; }

    public void setCvc(Long cvc) { this.cvc = cvc; }

    public String getExp_date() { return exp_date; }

    public void setExp_date(String exp_date) { this.exp_date = exp_date; }

    public boolean isDeleted() {return deleted; }

    public void setDeleted(boolean deleted) {this.deleted = deleted; }

    public boolean isAdmin() { return admin; }

    public void setAdmin(boolean admin) {this.admin = admin; }

    public Cart[] getCarts() { return carts; }

    public void setCarts(Cart[] carts) {this.carts = carts; }

    public Cart getCarts(int index) { return this.carts[index]; }

    public void setCarts(int index, Cart carts) {this.carts[index] = carts; }

}
