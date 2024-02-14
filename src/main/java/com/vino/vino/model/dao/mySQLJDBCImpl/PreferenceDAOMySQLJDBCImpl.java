package com.vino.vino.model.dao.mySQLJDBCImpl;

import com.vino.vino.model.dao.PreferenceDAO;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Coupon;
import com.vino.vino.model.mo.Preference;
import com.vino.vino.model.mo.Wine;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PreferenceDAOMySQLJDBCImpl implements PreferenceDAO {
    Connection conn;

    public PreferenceDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Preference create(
            Long user_id,
            String category,
            Long times) throws DuplicatedObjectException {

        PreparedStatement ps;
        Preference preference = new Preference();
        preference.setUserId(user_id);
        preference.setCategory(category);
        preference.setTimes(times);

        try {
            String sql
                    = " SELECT * "
                    + " FROM preference "
                    + " WHERE "
                    + " user_id = ? AND "
                    + " category = ? AND "
                    + " times = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user_id);
            ps.setString(i++, category);
            ps.setLong(i++, times);

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_preference_id = null;
            exist = resultSet.next();

            if (exist){
                deleted = resultSet.getString("deleted").equals("Y");
                retrived_preference_id = (resultSet.getLong("preference_id"));
            }

            resultSet.close();

            if (exist && !deleted) {
                throw new DuplicatedObjectException();
            }

            if (exist && deleted) {
                sql = "update preference set deleted='N' where preference_id=?";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_preference_id);
                ps.executeUpdate();
            }
            else {
                sql
                        = " INSERT INTO preference "
                        + "     (user_id,"
                        + "     category,"
                        + "     times,"
                        + "     deleted"
                        + "   ) "
                        + " VALUES (?,?,?,'N')";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, preference.getUserId());
                ps.setString(i++, preference.getCategory());
                ps.setLong(i++, preference.getTimes());

                ps.executeUpdate();
            }
        } catch (SQLException | DuplicatedObjectException e) {
            throw new RuntimeException(e);
        }

        return preference;
    }

    @Override
    public void update(Preference preference) throws DuplicatedObjectException {

        PreparedStatement ps;

        try {
            //controllo se esite una preferenza uguale ma con diverso id
            String sql
                    = " SELECT preference_id "
                    + " FROM preference "
                    + " WHERE "
                    + " deleted ='N' AND "
                    + " user_id = ? AND"
                    + " category = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, preference.getUserId());
            ps.setString(i++, preference.getCategory());

            ResultSet resultSet = ps.executeQuery();

            long retrieved_preference_id;
            if (resultSet.next()) {
                retrieved_preference_id = resultSet.getLong("preference_id");

                sql
                        = " UPDATE preference "
                        + " SET "
                        + " times = ?"
                        + " WHERE "
                        + "   preference_id = ? ";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, preference.getTimes());
                ps.setLong(i++, retrieved_preference_id);

                ps.executeUpdate();
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Preference findByUserCategory(Long user_id, String category) {

        PreparedStatement ps;
        Preference preference = null;

        try {

            String sql
                    = " SELECT * "
                    + " FROM preference "
                    + " WHERE "
                    + " user_id = ? AND "
                    + " category = ? AND "
                    + " deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user_id);
            ps.setString(2, category);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                preference = read(resultSet);
            } else {

                resultSet.close();
                ps.close();
                return null;
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return preference;
    }

    @Override
    public List<Preference> findAll(Long user_id) {

        PreparedStatement ps;
        Preference preference;
        ArrayList<Preference> preferences = new ArrayList<Preference>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM preference"
                    + " WHERE "
                    + "user_id = ? AND "
                    + " deleted ='N'";

            ps = conn.prepareStatement(sql);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                preference = read(resultSet);
                preferences.add(preference);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return preferences;
    }

    Preference read(ResultSet rs) {
        Preference preference = new Preference();
        try {
            preference.setPreferenceId(rs.getLong("preference_id"));
        } catch (SQLException sqle) {
        }
        try {
            preference.setUserId(rs.getLong("user_id"));
        } catch (SQLException sqle) {
        }
        try {
            preference.setCategory(rs.getString("category"));
        } catch (SQLException sqle) {
        }
        try {
            preference.setTimes(rs.getLong("times"));
        } catch (SQLException sqle) {
        }
        try {
            preference.setDeleted(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        return preference;
    }
}

