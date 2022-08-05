/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package store.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import store.utils.DBUtils;

public class RatingDAO {

    private static final String GET_PRODUCT_RATING = "SELECT id, fullName, content, star, rateDate FROM tblRating r JOIN tblProduct p ON r.productID = p.productID JOIN tblUsers u ON u.userID = r.userID AND p.productID = ?";
    private static final String INSERT_RATING = "INSERT INTO tblRating(productID, userID, orderID, content, star, rateDate) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String GET_PRODUCT_RATING_PER_ORDER = "select star, content, productID, rateDate FROM tblRating WHERE orderID = ?";

    public List<RatingDTO> getProductRating(int productID) throws SQLException {
        List<RatingDTO> ratingList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT_RATING);
                ptm.setInt(1, productID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int star = rs.getInt("star");
                    String content = rs.getString("content");
                    String fullName = rs.getString("fullName");
                    ratingList.add(new RatingDTO(star, content, fullName, productID));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return ratingList;
    }

    public boolean addRating(int productID, String userID, int orderID, String content, int star, String rateDate) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_RATING);
                ptm.setInt(1, productID);
                ptm.setString(2, userID);
                ptm.setInt(3, orderID);
                ptm.setString(4, content);
                ptm.setInt(5, star);
                ptm.setString(6, rateDate);
                result = ptm.executeUpdate() > 0;

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public List<RatingDTO> getProductRatingPerOrder(int orderID) throws SQLException {
        List<RatingDTO> ratingList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT_RATING_PER_ORDER);
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int star = rs.getInt("star");
                    String content = rs.getString("content");
                    int productID = rs.getInt("productID");
                    Date rateDate = rs.getDate("rateDate");
                    ratingList.add(new RatingDTO(star, content, null, productID, rateDate));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return ratingList;
    }

}
