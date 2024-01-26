package com.vino.vino.model.dao;

import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Preference;

import java.util.List;

public interface PreferenceDAO {

    public Preference create(
            Long user_id,
            String category,
            Long times) throws DuplicatedObjectException;

    public void update(Preference preference) throws DuplicatedObjectException;

    public Preference findByUserCategory(Long user_id, String category);

    public List<Preference> findAll(Long user_id);
}
