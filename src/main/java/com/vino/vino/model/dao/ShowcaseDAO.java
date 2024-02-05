package com.vino.vino.model.dao;

import com.vino.vino.model.dao.exception.DataTruncationException;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Showcase;
import com.vino.vino.model.mo.Wine;

import java.util.List;

public interface ShowcaseDAO {

    public Showcase create(
            Long wine_id) throws DuplicatedObjectException;

    public List<Showcase> findAll();

    public void delete(Wine wine);
}

