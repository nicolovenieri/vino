package com.vino.vino.model.dao;

import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;
import com.vino.vino.model.dao.exception.DataTruncationException;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
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
            Long phone,
            String city,
            Long cap,
            String street,
            String civic,
            Long card_n,
            Long cvc,
            String exp_date,
            boolean admin) throws DuplicatedObjectException, MysqlDataTruncation;

    public void update(User user) throws DuplicatedObjectException;

    public void delete(User user);

    public User findLoggedUser();

    public User findByUserId(Long user_id);

    public User findByUsername(String username);

    List<User> searchByUsername(String username);

    public List<User> findAll();

    public void setAdminStatusOn(User user);

    public void setAdminStatusOff(User user);
}
