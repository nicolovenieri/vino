package com.vino.vino.model.dao;

import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Language;
import com.vino.vino.model.mo.User;

public interface LanguageDAO {
    public Language create(String language);

    public void update(Language language);

    public void delete(Language language);
    public Language findlanguage();
}
