package com.vino.vino.model.dao.mySQLJDBCImpl;


import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.List;
import java.util.ArrayList;

import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;
import com.vino.vino.model.dao.exception.DataTruncationException;
import com.vino.vino.model.mo.User;
import com.vino.vino.model.mo.Wine;
import com.vino.vino.model.dao.WineDAO;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;

public class WineDAOMySQLJDBCImpl implements WineDAO {

    private final String COUNTER_ID = "wine_id";
    Connection conn;

    public WineDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Wine create(
            // Long wine_id,
            String name,
            String product_image,
            BigDecimal price,
            String denominazione,
            String annata,
            int avalaibility,
            String vitigni,
            String temperature,
            String format,
            int alcool,
            String category,
            String description
    ) throws DuplicatedObjectException, DataTruncationException {

        PreparedStatement ps;
        Wine wine = new Wine();
        //wine.setWineId(wine_id);
        wine.setName(name);
        wine.setProductImage(product_image);
        wine.setPrice(price);
        wine.setDenominazione(denominazione);
        wine.setAnnata(annata);
        wine.setAvalaibility(avalaibility);
        wine.setVitigni(vitigni);
        wine.setTemperature(temperature);
        wine.setFormat(format);
        wine.setAlcool(alcool);
        wine.setCategory(category);
        wine.setDescription(description);

        try {

            String sql
                    = " SELECT * "
                    + " FROM wine "
                    + " WHERE "
                    + " name = ? AND"
                    + " product_image = ? AND"
                    + " price = ? AND"
                    + " denominazione = ? AND"
                    + " annata = ? AND "
                    + " avalaibility = ? AND "
                    + " vitigni = ? AND "
                    + " temperature = ? AND "
                    + " format = ? AND "
                    + " category = ? AND "
                    + " description = ? AND "
                    + " alcool = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, wine.getName());
            ps.setString(i++, wine.getProductImage());
            ps.setBigDecimal(i++, wine.getPrice());
            ps.setString(i++, wine.getDenominazione());
            ps.setString(i++, wine.getAnnata());
            ps.setInt(i++, wine.getAvalaibility());
            ps.setString(i++, wine.getVitigni());
            ps.setString(i++, wine.getTemperature());
            ps.setString(i++, wine.getFormat());
            ps.setInt(i++, wine.getAlcool());
            ps.setString(i++, wine.getCategory());
            ps.setString(i++, wine.getDescription());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_wine_id = null;
            exist = resultSet.next();

            // leggo deleted e wine_id solo se esiste, altrimento ricevo nullPointer Exception
            if (exist) {
                deleted = resultSet.getString("deleted").equals("Y");
                retrived_wine_id = resultSet.getLong("wine_id");
            }

            resultSet.close();

            if (exist && !deleted) {
                throw new DuplicatedObjectException("WineDAOJDBCImpl.create: Tentativo di inserimento di un vino già esistente.");
            }

            if (exist && deleted){
                sql = "update wine set deleted='N' where wine_id=?";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_wine_id);
                ps.executeUpdate();
            }
            else {

                sql = "update counter set counterValue=counterValue+1 where counterId='" + COUNTER_ID + "'";

                ps = conn.prepareStatement(sql);
                ps.executeUpdate();

                sql = "SELECT counterValue FROM counter where counterId='" + COUNTER_ID + "'";

                ps = conn.prepareStatement(sql);
                resultSet = ps.executeQuery();
                resultSet.next();

                wine.setWineId(resultSet.getLong("counterValue"));

                resultSet.close();
                sql
                        = " INSERT INTO wine "
                        + "   ( wine_id,"
                        + "     name,"
                        + "     product_image,"
                        + "     price,"
                        + "     denominazione,"
                        + "     annata,"
                        + "     avalaibility,"
                        + "     vitigni,"
                        + "     temperature,"
                        + "     format,"
                        + "     alcool, "
                        + "     category, "
                        + "     description, "
                        + "     deleted "
                        + "   ) "
                        + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,'N')";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, wine.getWineId());
                ps.setString(i++, wine.getName());
                ps.setString(i++, wine.getProductImage());
                ps.setBigDecimal(i++, wine.getPrice());
                ps.setString(i++, wine.getDenominazione());
                ps.setString(i++, wine.getAnnata());
                ps.setInt(i++, wine.getAvalaibility());
                ps.setString(i++, wine.getVitigni());
                ps.setString(i++, wine.getTemperature());
                ps.setString(i++, wine.getFormat());
                ps.setInt(i++, wine.getAlcool());
                ps.setString(i++, wine.getCategory());
                ps.setString(i++, wine.getDescription());

                try {
                    ps.executeUpdate();
                } catch(MysqlDataTruncation e) {
                    throw new DataTruncationException(e.toString());
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return wine;
    }

    @Override
    public List<Wine> findAll() {

        PreparedStatement ps;
        Wine wine;
        ArrayList<Wine> wines = new ArrayList<Wine>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM wine"
                    + " WHERE "
                    + " deleted ='N'";

            ps = conn.prepareStatement(sql);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                wine = read(resultSet);
                wines.add(wine);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return wines;
    }

    @Override
    public void delete(Wine wine) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE wine "
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


    @Override
    public Wine findByWineId(Long wine_id) {

        PreparedStatement ps;
        Wine wine = null;

        try {

            String sql
                    = " SELECT *"
                    + " FROM wine "
                    + " WHERE "
                    + "wine_id = ? AND "
                    + "deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, wine_id);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                wine = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return wine;
    }

    @Override
    public List<Wine> findByName(String name) {

        PreparedStatement ps;
        Wine wine;
        ArrayList<Wine> wines = new ArrayList<Wine>();
        name = "%" + name + "%";

        try {

            String sql
                    = " SELECT *"
                    + " FROM wine "
                    + " WHERE "
                    + "name LIKE ? AND "
                    + "deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setString(1, name);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                wine = read(resultSet);
                wines.add(wine);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return wines;
    }

    @Override
    public void modify(Wine wine) throws DuplicatedObjectException, com.mysql.cj.exceptions.DataTruncationException, DataTruncationException {
        PreparedStatement ps;
        try {

            String sql
                    = " SELECT wine_id "
                    + " FROM wine "
                    + " WHERE "
//                    + " deleted ='N' AND "
                    + " name = ? AND"
                    + " product_image = ? AND"
                    + " price = ? AND"
                    + " denominazione = ? AND"
                    + " annata = ? AND "
                    + " avalaibility = ? AND "
                    + " vitigni = ? AND "
                    + " temperature = ? AND "
                    + " format = ? AND "
                    + " alcool = ? AND "
                    + " category = ? AND "
                    + " description = ? ";
//                    + " wine_id <> ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, wine.getName());
            ps.setString(i++, wine.getProductImage());
            ps.setBigDecimal(i++, wine.getPrice());
            ps.setString(i++, wine.getDenominazione());
            ps.setString(i++, wine.getAnnata());
            ps.setInt(i++, wine.getAvalaibility());
            ps.setString(i++, wine.getVitigni());
            ps.setString(i++, wine.getTemperature());
            ps.setString(i++, wine.getFormat());
            ps.setInt(i++, wine.getAlcool());
            ps.setString(i++, wine.getCategory());
            ps.setString(i++, wine.getDescription());
//            ps.setLong(i++, wine.getWineId());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_wine_id = null;
            exist = resultSet.next();

            // leggo deleted e wine_id solo se esiste, altrimento ricevo nullPointer Exception
            if (exist) {
                deleted = resultSet.getString("deleted").equals("Y");
                retrived_wine_id = resultSet.getLong("wine_id");
            }

            if (exist) {
                throw new DuplicatedObjectException("WineDAOJDBCImpl.create: Un vino con queste caratteristiche e' gia presente nel db.");
            }

            if (exist && deleted){
                sql = "update wine set deleted='N' where wine_id=?";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_wine_id);
                ps.executeUpdate();
            }

            sql
                    = " UPDATE wine "
                    + " SET "
                    + " name = ?,"
                    + " product_image = ?,"
                    + " price = ? ,"
                    + " denominazione = ? ,"
                    + " annata = ? , "
                    + " avalaibility = ? , "
                    + " vitigni = ? , "
                    + " temperature = ? , "
                    + " format = ? , "
                    + " alcool = ? ,"
                    + " category = ? ,"
                    + " description = ? "
                    + " WHERE "
                    + "   wine_id = ? ";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setString(i++, wine.getName());
            ps.setString(i++, wine.getProductImage());
            ps.setBigDecimal(i++, wine.getPrice());
            ps.setString(i++, wine.getDenominazione());
            ps.setString(i++, wine.getAnnata());
            ps.setInt(i++, wine.getAvalaibility());
            ps.setString(i++, wine.getVitigni());
            ps.setString(i++, wine.getTemperature());
            ps.setString(i++, wine.getFormat());
            ps.setInt(i++, wine.getAlcool());
            ps.setString(i++, wine.getCategory());
            ps.setString(i++, wine.getDescription());
            ps.setLong(i++, wine.getWineId());

            try {
                ps.executeUpdate();
            } catch(MysqlDataTruncation e) {
                throw new DataTruncationException("Importo massimo consentito: sei cifre intere e due decimali.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateAvalaibility(Long wine_id, int order_quantity) {
        PreparedStatement ps;
        try {

            Wine wine = null;
            String sql
                    = " SELECT *"
                    + " FROM wine "
                    + " WHERE "
                    + "wine_id = ? AND "
                    + "deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, wine_id);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                wine = read(resultSet);
            }
            resultSet.close();

            sql
                    = " UPDATE wine "
                    + " SET "
                    + " avalaibility = ? "
                    + " WHERE "
                    + " wine_id = ? ";

            int i = 1;
            ps = conn.prepareStatement(sql);
            ps.setInt(i++, wine.getAvalaibility() - order_quantity);
            ps.setLong(i++, wine_id);

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Wine> filterByCategory(String category) {

        PreparedStatement ps;
        Wine wine;
        ArrayList<Wine> wines = new ArrayList<Wine>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM wine"
                    + " WHERE"
                    + " category = ? AND"
                    + " deleted ='N'";

            ps = conn.prepareStatement(sql);
            ps.setString(1, category);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                wine = read(resultSet);
                wines.add(wine);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return wines;
    }

    Wine read(ResultSet rs) {
        Wine wine = new Wine();
        try {
            wine.setWineId(rs.getLong("wine_id"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setName(rs.getString("name"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setProductImage(rs.getString("product_image"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setPrice(rs.getBigDecimal("price"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setDenominazione(rs.getString("denominazione"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setAnnata(rs.getString("annata"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setAvalaibility(rs.getInt("avalaibility"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setVitigni(rs.getString("vitigni"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setTemperature(rs.getString("temperature"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setFormat(rs.getString("format"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setAlcool(rs.getInt("alcool"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setCategory(rs.getString("category"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setDescription(rs.getString("description"));
        } catch (SQLException sqle) {
        }
        try {
            wine.setDeleted(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        return wine;
    }
}
