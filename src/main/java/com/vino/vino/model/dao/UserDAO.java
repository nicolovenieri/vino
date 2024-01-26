package com.vino.vino.model.dao;

import com.vino.vino.model.mo.User;

import java.util.List;

public interface UserDAO {

    public User create(
            Long user_id,
            String username,
            String password,
            String email,
            String name,
            String surname,
            String phone,
            String city,
            Long cap,
            String street,
            String civic,
            Long card_n,
            Long cvc,
            String exp_date,
            boolean admin);

    public void update(User user);

    public void delete(User user);

    public User findLoggedUser();

    public User findByUserId(Long user_id);

    public User findByUsername(String username);

    List<User> searchByUsername(String username);

    public List<User> findAll();

    public void setAdminStatusOn(User user);

    public void setAdminStatusOff(User user);
}
