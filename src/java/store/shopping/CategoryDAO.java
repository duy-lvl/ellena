package store.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import store.utils.DBUtils;

public class CategoryDAO {

    private static final String SEARCH_CATEGORY = "SELECT categoryID, categoryName, [order], status FROM tblCategory WHERE dbo.fuChuyenCoDauThanhKhongDau(categoryName) LIKE ?";
    private static final String SEARCH_CATEGORY_WITH_STATUS = "SELECT categoryID, categoryName, [order], status FROM tblCategory WHERE dbo.fuChuyenCoDauThanhKhongDau(categoryName) LIKE ? AND status=?";
    private static final String SEARCH_CATEGORY_ALL = "SELECT categoryID, categoryName, [order], status FROM tblCategory";
    private static final String INSERT_CATEGORY = "INSERT INTO tblCategory VALUES (?, ?, ?)";
    private static final String UPDATE_CATEGORY = "UPDATE tblCategory SET categoryName=?, [order]=? WHERE categoryID=?";
    private static final String SELECT_LARGER_ORDER = "SELECT categoryID FROM tblCategory WHERE [order] >= ?";
    private static final String CHECK_DUPLICTE_ORDER = "SELECT [order] FROM tblCategory";
    private static final String INCREMENT_LARGER_ORDER_BY_ONE = "UPDATE tblCategory SET [order]=? WHERE categoryID=?";
    private static final String ACTIVATE_CATEGORY = "UPDATE tblCategory SET status=1 WHERE categoryID=?";
    private static final String DEACTIVATE_CATEGORY = "UPDATE tblCategory SET status=0 WHERE categoryID=?";
    private static final String CHECK_DUPLICATE_CATEGORY_NAME = "SELECT categoryID, categoryName, [order], status FROM tblCategory WHERE dbo.fuChuyenCoDauThanhKhongDau(categoryName) = ?";

    public List<CategoryDTO> getListCategory(String search, String Status) throws SQLException {
        List<CategoryDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if ("true".equalsIgnoreCase(Status) || "false".equalsIgnoreCase(Status)) {
                    ptm = conn.prepareStatement(SEARCH_CATEGORY_WITH_STATUS);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, Status);
                } else {
                    ptm = conn.prepareStatement(SEARCH_CATEGORY);
                    ptm.setString(1, "%" + search + "%");
                }
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int categoryID = rs.getInt("categoryID");
                    String categoryName = rs.getString("categoryName");
                    int order = rs.getInt("order");
                    boolean status = rs.getBoolean("status");
                    list.add(new CategoryDTO(categoryID, categoryName, order, status));
                }
            }
        } catch (Exception e) {
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
        return list;
    }

    public List<CategoryDTO> getAllCategory() throws SQLException {
        List<CategoryDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_CATEGORY_ALL);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int categoryID = rs.getInt("categoryID");
                    String categoryName = rs.getString("categoryName");
                    int order = rs.getInt("order");
                    boolean status = rs.getBoolean("status");
                    list.add(new CategoryDTO(categoryID, categoryName, order, status));
                }
            }
        } catch (Exception e) {
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
        return list;
    }

    public boolean addCategory(CategoryDTO cat) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(INSERT_CATEGORY);
                stm.setString(1, cat.getCategoryName());
                stm.setInt(2, cat.getOrder());
                stm.setBoolean(3, true);
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

    public boolean updateCategory(CategoryDTO cat) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_CATEGORY);
            ptm.setString(1, cat.getCategoryName());
            ptm.setInt(2, cat.getOrder());
            ptm.setInt(3, cat.getCategoryID());
            check = ptm.executeUpdate() > 0 ? true : false;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean checkDuplicateOrder(int order) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_DUPLICTE_ORDER);
                rs = ptm.executeQuery();
                int check_order;
                while (rs.next()) {
                    check_order = rs.getInt("order");
                    if (check_order == order) {
                        check = true;
                        break;
                    }
                }
            }
        } catch (Exception e) {
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
        return check;
    }
    
    public boolean checkDuplicateCategoryName(String categoryName) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(CHECK_DUPLICATE_CATEGORY_NAME);
                stm.setString(1, categoryName);
                rs = stm.executeQuery();
                if(rs.next()){
                    check = true;
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
        return check;
    }

    public List<Integer> listLargerOrderCategoryID(int order) throws SQLException {
        List<Integer> largerOrder = new ArrayList<Integer>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT_LARGER_ORDER);
                ptm.setInt(1, order);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int i = rs.getInt("categoryID");
                    largerOrder.add(i);
                }
            }
        } catch (Exception e) {
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
        return largerOrder;
    }

    public boolean incrementLargerOrderByOne(int order, int categoryID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INCREMENT_LARGER_ORDER_BY_ONE);
            ptm.setInt(1, order + 1);
            ptm.setInt(2, categoryID);
            check = ptm.executeUpdate() > 0 ? true : false;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean activateCategory(String categoryID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(ACTIVATE_CATEGORY);
            ptm.setString(1, categoryID);

            check = ptm.executeUpdate() > 0 ? true : false;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deactivateCategory(String categoryID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(DEACTIVATE_CATEGORY);
            ptm.setString(1, categoryID);
            check = ptm.executeUpdate() > 0 ? true : false;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
}
