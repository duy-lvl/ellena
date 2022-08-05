package store.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import store.utils.DBUtils;

public class UserDAO {

    private static final String LOGIN = "SELECT fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID=? AND password=?";
    private static final String CHECK_DUPLICATE = "SELECT fullName FROM tblUsers WHERE userID=?";
    private static final String INSERT = "INSERT tblUsers(userID, fullName, password, sex, roleID, address, birthday, phone, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_USER_BY_ID = "SELECT userID, fullName, password, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID=?";
    private static final String SEARCH_MANAGER = "SELECT userID, fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID LIKE ? AND roleID LIKE 'MN'";
    private static final String SEARCH_MANAGER_WITH_STATUS = "SELECT userID, fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID LIKE ? AND roleID LIKE 'MN' AND status=?";
    private static final String SEARCH_MANAGER_ALL = "SELECT userID, fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE roleID LIKE 'MN'";
    private static final String UPDATE_ACCOUNT = "UPDATE tblUsers SET fullName=?, sex=?, roleID=?, address=?, birthday=?, phone=? WHERE userID=?";
    private static final String UPDATE_PASSWORD = "UPDATE tblUsers SET password=? WHERE userID=?";
    private static final String UPDATE_NAME = "UPDATE tblUsers SET fullName=? WHERE userID=?";
    private static final String UPDATE_SEX = "UPDATE tblUsers SET sex=? WHERE userID=?";
    private static final String UPDATE_BIRTHDAY = "UPDATE tblUsers SET birthday=? WHERE userID=?";
    private static final String UPDATE_ADDRESS = "UPDATE tblUsers SET address=? WHERE userID=?";
    private static final String UPDATE_PHONE = "UPDATE tblUsers SET phone=? WHERE userID=?";
    private static final String ACTIVATE_ACCOUNT = "UPDATE tblUsers SET status=1 WHERE userID=?";
    private static final String DEACTIVATE_ACCOUNT = "UPDATE tblUsers SET status=0 WHERE userID=?";
    private static final String STATISTIC_ORDER_QUANITY = "SELECT orderDate, COUNT(*) AS [orderQuantity], SUM(total) AS [income], SUM(quantity) as [productQuantity] FROM tblOrder o JOIN tblOrderDetail d ON o.orderID = d.orderID GROUP BY orderDate";
    private static final String SEARCH_USER_ALL = "WITH subTable AS ("
            + "                 SELECT userID, fullName, sex, roleID, address, birthday, phone, status, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as row# "
            + "                 FROM tblUsers "
            + "                 )"
            + "SELECT userID, fullName, sex, roleID, address, birthday, phone, status "
            + "FROM subTable "
            + "WHERE row# BETWEEN ? AND ? ";
    private static final String NUMBER_OF_ALL_USER = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblUsers";
    private static final String SEARCH_USER = "WITH subTable AS ("
            + "			SELECT userID, fullName, sex, roleID, address, birthday, phone, status, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as row# "
            + "			FROM tblUsers "
            + "			WHERE userID LIKE ? "
            + "			)"
            + "SELECT userID, fullName, sex, roleID, address, birthday, phone, status "
            + "FROM subTable "
            + "WHERE row# BETWEEN ? AND ? ";
    private static final String NUMBER_OF_SEARCH_USER = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblUsers WHERE userID LIKE ?";
    private static final String SEARCH_USER_WITH_ROLE_ID = "WITH subTable AS ("
            + "			SELECT userID, fullName, sex, roleID, address, birthday, phone, status, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as row# "
            + "			FROM tblUsers "
            + "			WHERE userID LIKE ? AND roleID LIKE ? "
            + "			)"
            + "SELECT userID, fullName, sex, roleID, address, birthday, phone, status "
            + "FROM subTable "
            + "WHERE row# BETWEEN ? AND ? ";
    private static final String NUMBER_OF_SEARCH_USER_WITH_ROLE_ID = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblUsers WHERE userID LIKE ? AND roleID LIKE ?";
    private static final String SEARCH_USER_WITH_STATUS = "WITH subTable AS ("
            + "			SELECT userID, fullName, sex, roleID, address, birthday, phone, status, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as row# "
            + "			FROM tblUsers "
            + "			WHERE userID LIKE ? AND roleID LIKE ? AND status=? "
            + "			)"
            + "SELECT userID, fullName, sex, roleID, address, birthday, phone, status "
            + "FROM subTable "
            + "WHERE row# BETWEEN ? AND ? ";
    private static final String NUMBER_OF_SEARCH_USER_WITH_STATUS = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblUsers WHERE userID LIKE ? AND roleID LIKE ? AND status=?";
    private static final String SEARCH_RETURNED_HISTORY = "SELECT DISTINCT u.userID, u.fullName, u.sex, u.address, u.phone "
            + "FROM tblUsers u JOIN tblOrder o ON u.userID = o.userID JOIN tblOrderStatusUpdate osu ON o.orderID = osu.orderID "
            + "WHERE osu.statusID = 8 AND (u.fullName LIKE ? OR u.phone LIKE ? OR u.userID LIKE ?) AND u.status > 0";

    //-------------------------------
    private int numberOfUser;

    public int getNumberOfUser() {
        return numberOfUser;
    }

    //-------------------------------
    public UserDTO checkLogin(String userID, String password) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(LOGIN);
                stm.setString(1, userID);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    user = new UserDTO(userID, fullName, password, sex, roleID, address, birthday, phone, status);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return user;
    }

    public boolean checkDuplicate(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(CHECK_DUPLICATE);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return check;
    }

    public boolean addUser(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT);
            String id = user.getUserID();
            String name = user.getFullName();
            String password = user.getPassword();
            boolean sex = user.getSex();
            String roleID = user.getRoleID();
            String address = user.getAddress();
            Date date = user.getBirthday();
            String phone = user.getPhone();
            boolean status = user.isStatus();
            ptm.setString(1, id);
            ptm.setString(2, name);
            ptm.setString(3, password);
            ptm.setBoolean(4, sex);
            ptm.setString(5, roleID);
            ptm.setString(6, address);
            if (date != null) {
                ptm.setDate(7, new java.sql.Date(date.getTime()));
            } else {
                ptm.setDate(7, null);
            }
            ptm.setString(8, phone);
            ptm.setBoolean(9, status);
            check = ptm.executeUpdate() > 0 ? true : false;

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
        return check;
    }

    public List<UserDTO> getListUsers(String search, String roleID, String Status, int offset, int noOfProducts) throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if ("".equals(roleID)) {
                    ptm = conn.prepareStatement(SEARCH_USER);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setInt(2, offset);
                    ptm.setInt(3, noOfProducts);
                } else if ("true".equalsIgnoreCase(Status) || "false".equalsIgnoreCase(Status)) {
                    ptm = conn.prepareStatement(SEARCH_USER_WITH_STATUS);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, roleID);
                    ptm.setString(3, Status);
                    ptm.setInt(4, offset);
                    ptm.setInt(5, noOfProducts);
                } else {
                    ptm = conn.prepareStatement(SEARCH_USER_WITH_ROLE_ID);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, roleID);
                    ptm.setInt(3, offset);
                    ptm.setInt(4, noOfProducts);

                }
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    String role = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    list.add(new UserDTO(userID, fullName, "*******", sex, role, address, birthday, phone, status));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                if ("".equals(roleID)) {
                    ptm = conn.prepareStatement(NUMBER_OF_SEARCH_USER);
                    ptm.setString(1, "%" + search + "%");
                } else if ("true".equalsIgnoreCase(Status) || "false".equalsIgnoreCase(Status)) {
                    ptm = conn.prepareStatement(NUMBER_OF_SEARCH_USER_WITH_STATUS);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, roleID);
                    ptm.setString(3, Status);
                } else {
                    ptm = conn.prepareStatement(NUMBER_OF_SEARCH_USER_WITH_ROLE_ID);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, roleID);

                }
                
                rs = ptm.executeQuery();
                if (rs.next()) {
                    this.numberOfUser = rs.getInt("ROW_COUNT");
                }
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

    public List<UserDTO> getAllUsers(int offset, int noOfProducts) throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_USER_ALL);
                ptm.setInt(1, offset);
                ptm.setInt(2, noOfProducts);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    list.add(new UserDTO(userID, fullName, "*******", sex, roleID, address, birthday, phone, status));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                ptm = conn.prepareStatement(NUMBER_OF_ALL_USER);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    this.numberOfUser = rs.getInt("ROW_COUNT");
                }
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

    public UserDTO getUserByID(String userID) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_USER_BY_ID);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String password = rs.getString("password");
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    user = new UserDTO(userID, fullName, password, sex, roleID, address, birthday, phone, status);
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
        return user;
    }

    public List<UserDTO> getListManagers(String search, String Status) throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if ("true".equalsIgnoreCase(Status) || "false".equalsIgnoreCase(Status)) {
                    ptm = conn.prepareStatement(SEARCH_MANAGER_WITH_STATUS);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, Status);
                } else {
                    ptm = conn.prepareStatement(SEARCH_MANAGER);
                    ptm.setString(1, "%" + search + "%");
                }
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    list.add(new UserDTO(userID, fullName, "*******", sex, roleID, address, birthday, phone, status));
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

    public List<UserDTO> getAllManagers() throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_MANAGER_ALL);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    list.add(new UserDTO(userID, fullName, "*******", sex, roleID, address, birthday, phone, status));
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

    public boolean updateAccount(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_ACCOUNT);
            ptm.setString(1, user.getFullName());
            ptm.setBoolean(2, user.getSex());
            ptm.setString(3, user.getRoleID());
            ptm.setString(4, user.getAddress());
            ptm.setDate(5, new java.sql.Date((user.getBirthday()).getTime()));
            ptm.setString(6, user.getPhone());
            ptm.setString(7, user.getUserID());

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

    public boolean updatePassword(String password, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_PASSWORD);
            ptm.setString(1, password);
            ptm.setString(2, userID);

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

    public boolean updateSex(String newSex, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_SEX);
            ptm.setBoolean(1, Boolean.parseBoolean(newSex));
            ptm.setString(2, userID);

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

    public boolean updateBirthday(Date newBirthday, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_BIRTHDAY);
            ptm.setDate(1, new java.sql.Date(newBirthday.getTime()));
            ptm.setString(2, userID);

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

    public boolean updateName(String newName, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_NAME);
            ptm.setString(1, newName);
            ptm.setString(2, userID);

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

    public boolean updateAddress(String newAddress, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_ADDRESS);
            ptm.setString(1, newAddress);
            ptm.setString(2, userID);

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

    public boolean updatePhone(String newPhone, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_PHONE);
            ptm.setString(1, newPhone);
            ptm.setString(2, userID);

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

    public boolean activateAccount(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(ACTIVATE_ACCOUNT);
            ptm.setString(1, userID);

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

    public boolean deactivateAccount(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(DEACTIVATE_ACCOUNT);
            ptm.setString(1, userID);
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

    public Map<String, Integer> getStatisticOrders() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        Map<String, Integer> map = new HashMap<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(STATISTIC_ORDER_QUANITY);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String date = rs.getString("orderDate");
                    int quantity = rs.getInt("quantity");
                    map.put(date, quantity);
                }
                SimpleDateFormat DateFor = new SimpleDateFormat("yyyy-MM-dd");
                Calendar cal = Calendar.getInstance();
                for (int i = 0; i < 30; i++) {
                    String stringDate = DateFor.format(cal.getTime());
                    if (map.get(stringDate) == null) {
                        map.put(stringDate, 0);
                    }

                    cal.add(Calendar.DATE, -1);
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
        return map;
    }
    
    public List<UserDTO> getReturnedCustomer(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<UserDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_RETURNED_HISTORY);
                ptm.setString(1, "%" + search + "%");
                ptm.setString(2, "%" + search + "%");
                ptm.setString(3, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    UserDTO user = new UserDTO(userID, fullName, sex, address, phone);
                    list.add(user);
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
}
