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
import java.util.List;
import store.utils.DBUtils;

/**
 *
 * @author vankh
 */
public class CartProductDAO {
    private static final String INSERT_CART_ITEMS = "INSERT INTO tblCartItems(productID, sessionID, quantity, size, color) VALUES(?, ?, ?, ?, ?)";
    private static final String GET_CART_ITEMS_BY_SESSIONID = "SELECT * FROM tblCartItems WHERE sessionID = ?";
    private static final String UPDATE_QUANTITY = "UPDATE tblCartItems SET quantity = ? WHERE sessionID = ? AND productID = ?";
    private static final String DELETE_ALL_CART_ITEMS = "DELETE FROM tblCartItems WHERE sessionID = ?";
    private static final String DELETE_A_CART_ITEM = "DELETE FROM tblCartItems WHERE sessionID = ? AND productID=? AND size=? AND color=?";
    
    public boolean addCartItems(CartProduct cartItem) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(INSERT_CART_ITEMS);
                stm.setInt(1, cartItem.getProductID());
                stm.setInt(2, cartItem.getSessionID());
                stm.setInt(3, cartItem.getQuantity());
                stm.setString(4, cartItem.getSize());
                stm.setString(5, cartItem.getColor());
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
    
    public List<CartProduct> getCartItemsBySessionID(int sessionID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<CartProduct> cartItem = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_CART_ITEMS_BY_SESSIONID);
                stm.setInt(1, sessionID);
                rs = stm.executeQuery();
                while(rs.next()){
                    int productID = rs.getInt("productID");
                    int quantity = rs.getInt("quantity");
                    String color = rs.getString("color");
                    String size = rs.getString("size");
                    cartItem.add(new CartProduct(productID, sessionID, quantity, size, color));
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
        return cartItem;
    }
    
    public boolean updateProductQuantity(int quantity, int sessionID, int productID) throws SQLException{
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_QUANTITY);
                ptm.setInt(1, quantity);
                ptm.setInt(2, sessionID);
                ptm.setInt(3, productID);
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
    
    public boolean deleteAllCartItems(int sessionID) throws SQLException{
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
       
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_ALL_CART_ITEMS);
                ptm.setInt(1, sessionID);
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
    
    public boolean deleteACartItem(int sessionID, int productID, String size, String color) throws SQLException{
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
       
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_A_CART_ITEM);
                ptm.setInt(1, sessionID);
                ptm.setInt(2, productID);
                ptm.setString(3, size);
                ptm.setString(4, color);
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
