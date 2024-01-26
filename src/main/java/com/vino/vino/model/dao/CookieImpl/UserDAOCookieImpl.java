package com.vino.vino.model.dao.CookieImpl;

import com.vino.vino.model.dao.UserDAO;
import com.vino.vino.model.mo.User;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;


public class UserDAOCookieImpl implements UserDAO {

    HttpServletRequest request;
    HttpServletResponse response;

    public UserDAOCookieImpl(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }

    @Override
    public User create(Long user_id,
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
                       boolean admin) {

        User loggedUser = new User();
        loggedUser.setUserId(user_id);
        loggedUser.setName(name);
        loggedUser.setSurname(surname);
        loggedUser.setAdmin(admin);

        Cookie cookie;
        cookie = new Cookie("loggedUser", encode(loggedUser));
        cookie.setPath("/");
        response.addCookie(cookie);

        return loggedUser;

    }

    @Override
    public void update(User loggedUser) {

        Cookie cookie;
        cookie = new Cookie("loggedUser", encode(loggedUser));
        cookie.setPath("/");
        response.addCookie(cookie);

    }

    @Override
    public void delete(User loggedUser) {

        Cookie cookie;
        cookie = new Cookie("loggedUser", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);

    }

    @Override
    public User findLoggedUser() {

        Cookie[] cookies = request.getCookies();
        User loggedUser = null;

        if (cookies != null) {
            for (int i = 0; i < cookies.length && loggedUser == null; i++) {
                if (cookies[i].getName().equals("loggedUser")) {
                    loggedUser = decode(cookies[i].getValue());
                }
            }
        }

        return loggedUser;

    }

    @Override
    public User findByUserId(Long user_id) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public User findByUsername(String username) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public List<User> searchByUsername(String username) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void setAdminStatusOn(User user) { throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void setAdminStatusOff(User user) { throw new UnsupportedOperationException("Not supported yet.");
    }

    private String encode(User loggedUser) {

        String encodedLoggedUser;
        encodedLoggedUser = loggedUser.getUserId() + "#" + loggedUser.getName() + "#" + loggedUser.getSurname() + "#" + loggedUser.isAdmin();
        return encodedLoggedUser;

    }

    private User decode(String encodedLoggedUser) {

        User loggedUser = new User();

        String[] values = encodedLoggedUser.split("#");

        loggedUser.setUserId(Long.parseLong(values[0]));
        loggedUser.setName(values[1]);
        loggedUser.setSurname(values[2]);
        loggedUser.setAdmin(Boolean.parseBoolean(values[3]));

        return loggedUser;

    }

    @Override
    public List<User> findAll() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}

