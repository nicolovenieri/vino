package com.vino.vino.model.dao.CookieImpl;

import com.vino.vino.model.dao.LanguageDAO;
import com.vino.vino.model.mo.Language;
import com.vino.vino.model.mo.User;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LanguageDAOCookieImpl implements LanguageDAO {
    HttpServletRequest request;
    HttpServletResponse response;
    public LanguageDAOCookieImpl(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }
    @Override
    public Language create(String language) {
        Language cookielanguage = new Language();
        cookielanguage.setLanguage(language);

        Cookie cookie;
        cookie = new Cookie("cookielanguage", encode(cookielanguage));
        cookie.setPath("/");
        response.addCookie(cookie);

        return cookielanguage;
    }

    @Override
    public void update(Language language) {

    }

    @Override
    public void delete(Language language) {

    }

    @Override
    public Language findlanguage() {
        Cookie[] cookies = request.getCookies();
        Language cookielanguage = null;

        if (cookies != null) {
            for (int i = 0; i < cookies.length && cookielanguage == null; i++) {
                if (cookies[i].getName().equals("cookielanguage")) {
                    cookielanguage = decode(cookies[i].getValue());
                }
            }
        }

        return cookielanguage;
    }

    private String encode(Language cookielanguage) {

        String encodedcookielanguage;
        encodedcookielanguage = cookielanguage.getLanguage();
        return encodedcookielanguage;

    }

    private Language decode(String encodedcookielanguage) {

        Language cookielanguage = new Language();

        String[] values = encodedcookielanguage.split("#");

        cookielanguage.setLanguage(encodedcookielanguage);

        return cookielanguage;

    }
}
