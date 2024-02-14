package com.vino.vino.model.dao.mySQLJDBCImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.List;
import java.util.ArrayList;

import com.vino.vino.model.dao.ShowcaseDAO;
import com.vino.vino.model.dao.WineDAO;
import com.vino.vino.model.dao.exception.DataTruncationException;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Showcase;
import com.vino.vino.model.mo.Wine;

public class ShowcaseDAOMySQLJDBCImpl implements ShowcaseDAO {
    Connection conn;

    public ShowcaseDAOMySQLJDBCImpl(Connection conn) { this.conn = conn; }

    @Override
    public Showcase create(Long wine_id) throws DuplicatedObjectException {

        PreparedStatement ps;
        Showcase showcase = new Showcase();
        showcase.setWineId(wine_id);
        String sql;

        try {
            sql
                    = " SELECT COUNT(*)num "
                    + " FROM showcase "
                    + " WHERE deleted = 'N' ";
                ps = conn.prepareStatement(sql);

                ResultSet rs = ps.executeQuery();
                int conta = 0;

                if (rs.next()){
                    conta = rs.getInt("num");
                }
                rs.close();

                if(conta >= 3){
                    throw new RuntimeException("Limite showcase raggiunto.");
                }

                sql
                        = " SELECT * "
                        + " FROM showcase "
                        + " WHERE "
                        + " wine_id = ? ";

                ps = conn.prepareStatement(sql);
                int i = 1;
                ps.setLong(i++, showcase.getWineId());
                ResultSet resultSet = ps.executeQuery();

                boolean exist;
                boolean deleted = true;
                Long retrived_showcase_id = null;
                exist = resultSet.next();
                if (exist) {
                    deleted = resultSet.getString("deleted").equals("Y");
                    retrived_showcase_id = resultSet.getLong("showcase_id");
                }

                resultSet.close();

                if (exist && !deleted) {
                    throw new DuplicatedObjectException("ShowcaseDAOJDBCImpl.create: Tentativo di inserimento di un vino già in vetrina.");
                }

                if (exist && deleted) {
                    sql
                            = " UPDATE showcase "
                            + " SET deleted = 'N' "
                            + " WHERE showcase_id = ? ";
                    ps = conn.prepareStatement(sql);
                    i = 1;
                    ps.setLong(i++, retrived_showcase_id);
                    ps.executeUpdate();
                } else {
                    sql
                            = " INSERT INTO showcase "
                            + " (wine_id, "
                            + " deleted) "
                            + " VALUES (?,'N')";

                    ps = conn.prepareStatement(sql);
                    i = 1;
                    ps.setLong(i++, showcase.getWineId());
                    ps.executeUpdate();
                }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return showcase;
    }

    @Override
    public List<Showcase> findAll() {

        PreparedStatement ps;
        Showcase showcase;
        ArrayList<Showcase> showcases = new ArrayList<Showcase>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM showcase"
                    + " WHERE "
                    + " deleted ='N'";

            ps = conn.prepareStatement(sql);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                showcase = read(resultSet);
                showcases.add(showcase);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return showcases;
    }

    @Override
    public void delete(Wine wine) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE showcase "
                    + " SET deleted='Y' "
                    + " WHERE "
                    + " wine_id=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, wine.getWineId());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    Showcase read(ResultSet rs) {
        Showcase showcase = new Showcase();
        try {
            showcase.setShowcaseId(rs.getLong("showcase_id"));
        } catch (SQLException sqle) {
        }
        try {
            showcase.setWineId(rs.getLong("wine_id"));
        } catch (SQLException sqle) {
        }
        try {
            showcase.setDeleted(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        return showcase;
    }
}

