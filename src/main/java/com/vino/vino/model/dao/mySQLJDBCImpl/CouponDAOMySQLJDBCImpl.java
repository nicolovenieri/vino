package com.vino.vino.model.dao.mySQLJDBCImpl;

import com.vino.vino.model.dao.CouponDAO;
import com.vino.vino.model.dao.exception.DuplicatedObjectException;
import com.vino.vino.model.mo.Order;
import com.vino.vino.model.mo.User;
import com.vino.vino.model.mo.Wine;
import com.vino.vino.model.mo.Cart;
import com.vino.vino.model.mo.Coupon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;



public class CouponDAOMySQLJDBCImpl implements CouponDAO {

//    private final String COUNTER_ID = "coupon_id";
    Connection conn;

    public CouponDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Coupon create(
            String name,
            Long discount,
            Date exp_date
    ) throws DuplicatedObjectException{

        PreparedStatement ps;
        Coupon coupon = new Coupon();
        coupon.setName(name);
        coupon.setDiscount(discount);
        coupon.setExp_date(exp_date);


        try {

            //provo a vedere se esite gia una tupla con name uguale
            String sql
                    = " SELECT * "
                    + " FROM coupon "
                    + " WHERE "
                    + " name = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, name);

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_coupon_id = null;
            exist = resultSet.next();

            // leggo deleted e coupon_id solo se esiste, altrimento ricevo nullPointer Exception
            if (exist){
                deleted = resultSet.getString("deleted").equals("Y");
                retrived_coupon_id = (resultSet.getLong("coupon_id"));
            }

            resultSet.close();

            if (exist && !deleted) {
                throw new DuplicatedObjectException("CouponDAOJDBCImpl.create: Tentativo di inserimento di un coupon già esistente.");
            }

            if (exist && deleted) {
                sql = "update coupon set deleted='N' where coupon_id=?";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_coupon_id);
                ps.executeUpdate();
            }
            else {
/*
                sql = "update counter set counterValue=counterValue+1 where counterId='" + COUNTER_ID + "'";

                ps = conn.prepareStatement(sql);
                ps.executeUpdate();

                sql = "SELECT counterValue FROM counter where counterId='" + COUNTER_ID + "'";

                ps = conn.prepareStatement(sql);
                resultSet = ps.executeQuery();
                resultSet.next();

                coupon.setCouponId(resultSet.getLong("counterValue"));

                resultSet.close();

 */
                sql
                        = " INSERT INTO coupon "
                        + "     (name,"
                        + "     discount,"
                        + "     exp_date,"
                        + "     deleted "
                        + "   ) "
                        + " VALUES (?,?,?,'N')";

                ps = conn.prepareStatement(sql);
                i = 1;
                //ps.setLong(i++, coupon.getCouponId());
                ps.setString(i++, coupon.getName());
                ps.setLong(i++, coupon.getDiscount());
                ps.setDate(i++, coupon.getExp_date());

                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return coupon;
    }

    @Override
    public void modify(Coupon coupon) throws DuplicatedObjectException {

        PreparedStatement ps;
        try {

            //controllo se esite un Coupon uguale ma con diverso id
            String sql
                    = " SELECT coupon_id "
                    + " FROM coupon "
                    + " WHERE "
                    + " deleted ='N' AND "
                    + " name = ? AND"
                    + " coupon_id <> ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, coupon.getName());
            ps.setLong(i++, coupon.getCouponId());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            exist = resultSet.next();
            resultSet.close();

            if (exist) {
                throw new DuplicatedObjectException("CouponDAOJDBCImpl.create: Tentativo di aggiornamento IN un coupon già esistente.");
            }

            sql
                    = " UPDATE coupon "
                    + " SET "
                    + " name = ?,"
                    + " discount = ?,"
                    + " exp_date = ?"
                    + " WHERE "
                    + "   coupon_id = ? ";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setString(i++, coupon.getName());
            ps.setLong(i++, coupon.getDiscount());
            ps.setDate(i++, coupon.getExp_date());
            ps.setLong(i++, coupon.getCouponId());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void delete(Coupon coupon) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE coupon "
                    + " SET deleted='Y' "
                    + " WHERE "
                    + " coupon_id=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, coupon.getCouponId());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public Coupon findByCouponId(Long coupon_id) {

        PreparedStatement ps;
        Coupon coupon = null;

        try {

            String sql
                    = " SELECT *"
                    + " FROM coupon "
                    + " WHERE "
                    + "coupon_id = ? AND "
                    + "deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, coupon_id);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                coupon = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return coupon;
    }

    @Override
    public Coupon SearchByCouponName(String coupon_name) {

        PreparedStatement ps;
        Coupon coupon = null;

        try {

            String sql
                    = " SELECT *"
                    + " FROM coupon "
                    + " WHERE "
                    + " name = ? AND "
                    + " deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setString(1, coupon_name);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                coupon = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return coupon;
    }

    @Override
    public List<Coupon> findAll() {

        PreparedStatement ps;
        Coupon coupon;
        ArrayList<Coupon> coupons = new ArrayList<Coupon>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM coupon"
                    + " WHERE "
                    + " deleted ='N'";

            ps = conn.prepareStatement(sql);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                coupon = read(resultSet);
                coupons.add(coupon);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return coupons;
    }

    Coupon read(ResultSet rs) {
        Coupon coupon = new Coupon();

        try {
            coupon.setCouponId(rs.getLong("coupon_id"));
        } catch (SQLException sqle) {
        }
        try {
            coupon.setName(rs.getString("name"));
        } catch (SQLException sqle) {
        }
        try {
            coupon.setDiscount(rs.getLong("discount"));
        } catch (SQLException sqle) {
        }
        try {
            coupon.setExp_date(rs.getDate("exp_date"));
        } catch (SQLException sqle) {
        }
        try {
            coupon.setDeleted(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        return coupon;
    }

}
