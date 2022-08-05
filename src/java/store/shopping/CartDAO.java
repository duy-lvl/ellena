/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package store.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import store.utils.DBUtils;

/**
 *
 * @author vankh
 */
public class CartDAO {
    private static final String INSERT_CART = "INSERT INTO tblCart(userID, fullName, address, phone, email, note, payType) VALUES(?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_CART_BY_USERID = "SELECT * FROM tblCart WHERE userID LIKE ?";
    private static final String UPDATE_CART_INFO = "UPDATE tblCart SET fullName = ?, phone = ?, address = ?, email = ?, note = ?, payType = ? WHERE userID LIKE ?";
    
    public boolean addCart(Cart cart) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(INSERT_CART);
                stm.setString(1, cart.getUserID());
                stm.setString(2, cart.getFullName());
                stm.setString(3, cart.getAddress());
                stm.setString(4, cart.getPhone());
                stm.setString(5, cart.getEmail());
                stm.setString(6, cart.getNote());
                stm.setString(7, cart.getPayType());
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public Cart getCartByUserID(String userID) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Cart cart = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_CART_BY_USERID);
                stm.setString(1, "%" + userID + "%");
                rs = stm.executeQuery();
                if(rs.next()){
                    int id = (rs.getInt("id"));              
                    String fullName = rs.getString("fullName");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String note = rs.getString("note");
                    String payType = rs.getString("payType");
                    cart = new Cart(id, userID, fullName, phone, address, email, note, payType);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return cart;
    }
    
    public boolean updateCartInfo(String fullName, String phone, String address, String email, String note, String userID, String payType) throws SQLException{
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;      

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_CART_INFO);
                ptm.setString(1, fullName);
                ptm.setString(2, phone);
                ptm.setString(3, address);
                ptm.setString(4, email);
                ptm.setString(5, note);
                ptm.setString(6, payType);
                ptm.setString(7, "%" + userID + "%");
                result = ptm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return result;
    }
}
