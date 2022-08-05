package store.shopping;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javafx.util.Pair;
import store.utils.DBUtils;

public class OrderDAO {

    private static final String UPDATE_TRACKINGID = "UPDATE tblOrder SET trackingID = ? WHERE orderID = ?";

//    private static final String SEARCH_ORDER_ALL = "SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
//            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID ";
    private static final String SEARCH_ORDER_BY_ID = "SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "WHERE v1.orderID = ?";

//    private static final String SEARCH_ORDER_BY_STATUS = "SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
//            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
//            + "AND statusID = ? "
//            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";
//    private static final String SEARCH_ORDER = "SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
//            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
//            + "WHERE (orderDate BETWEEN ? AND ?) "
//            + "AND statusID = ? "
//            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";
//    private static final String SEARCH_ORDER_BY_DATE = "SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
//            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
//            + "WHERE (orderDate BETWEEN ? AND ?) "
//            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";
    private static final String UPDATE_ORDER_STATUS = "INSERT INTO tblOrderStatusUpdate(statusID, orderID, updateDate, modifiedBy, roleID) VALUES (?, ?, GETDATE(), ?, ?)";

//    private static final String SEARCH_ORDER_BY_NAME = "SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
//            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
//            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";
    //Order detail
    private static final String SEARCH_ORDER_DETAIL = "SELECT detailID, t1.productID, productName, t1.price, quantity, size, color "
            + "FROM tblOrderDetail t1 JOIN tblProduct t2 ON t1.productID = t2.productID "
            + "WHERE orderID = ? AND quantity > 0";

    //Order status
    private static final String SEARCH_ORDER_STATUS = "SELECT t1.statusID, updateDate, statusName, modifiedBy, t3.roleID, t3.fullName \n"
            + "FROM tblOrderStatusUpdate t1 JOIN tblOrderStatus t2 ON t1.statusID = t2.statusID \n"
            + "		LEFT JOIN tblUsers t3 ON t3.userID = modifiedBy\n"
            + "WHERE orderID = ?";

    private static final String INSERT_ORDER = "INSERT INTO tblOrder(orderDate, total, userID, payType, fullName, [address], phone, email, note, transactionNumber) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String INSERT_ORDER_DETAIL = "INSERT INTO tblOrderDetail(price, quantity, size, color, orderID, productID) VALUES(?, ?, ?, ?, ?, ?)";

    private static final String GET_ORDER_ID = "SELECT TOP 1 orderID FROM tblOrder WHERE userID LIKE ? + '%' ORDER BY orderID DESC";

    private static final String GET_ORDER_TRACKING_ID = "SELECT trackingID FROM tblOrder WHERE orderID = ?";

    private static final String GET_ORDER_HISTORY = "SELECT v2.orderID, orderDate, total, statusName, payType\n"
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID WHERE v2.orderID in \n"
            + "(SELECT orderID FROM tblOrder WHERE userID = ?)\n"
            + "ORDER BY v2.orderID desc";

    private static final String GET_ORDER_DETAIL = "SELECT top 1 with ties \n"
            + "p.productID, productName, od.detailID, od.price, od.quantity, od.color, r.returnType, r.note, od.size, image\n"
            + "FROM tblProduct p JOIN tblOrderDetail od ON p.productID = od.productID\n"
            + "JOIN tblProductColors pc ON p.productID = pc.productID AND od.color = pc.color\n"
            + "JOIN tblColorImage ci ON ci.productColorID = pc.productColorID  \n"
            + "LEFT JOIN tblReturns r ON od.detailID = r.detailID WHERE orderID = ?\n"
            + "ORDER BY ROW_NUMBER() over (partition by p.productID, od.color, od.size order by image)";

    private static final String GET_ORDER = "SELECT v1.orderID, orderDate, total, statusID, statusName, payType, trackingID, fullName, address, phone, email, note FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID WHERE v2.orderID = ?";

    private static final String GET_STATUS_HISTORY = "SELECT statusID, updateDate\n"
            + "FROM tblOrderStatusUpdate WHERE orderID = ?";

    private static final String UPDATE_ORDER_DETAIL = "UPDATE tblOrderDetail SET quantity = ? WHERE detailID = ?";

    private static final String UPDATE_ORDER_TOTAL = "UPDATE tblOrder SET total = ? WHERE orderID = ?";

    private static final String INSERT_ORDER_RETURN = "INSERT INTO tblReturns(detailID, quantity, returnType, returnDate, note) VALUES(?, ?, ?, GETDATE(), ?)";

    private static final String GET_ORDER_TOTAL = "SELECT total FROM tblOrder WHERE orderID = ?";

    private static final String CHECK_ORDER_DUPLICATE_ITEM = "SELECT detailID, quantity FROM tblOrderDetail WHERE orderID = ? AND productID = ? AND color LIKE ? AND size LIKE ?";

    private static final String GET_RETURN_HISTORY = "SELECT t1.detailID, t1.productID, productName, t1.price, t1.quantity, size, color, t3.quantity AS [returnQuantity], returnType, returnDate, note \n"
            + "FROM tblOrderDetail t1 JOIN tblProduct t2 ON t1.productID = t2.productID JOIN tblReturns t3 ON t1.detailID = t3.detailID\n"
            + "WHERE orderID = ?";
    private static final String SEARCH_ORDER_ALL = "WITH subTable AS (\n"
            + "			SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber, ROW_NUMBER() OVER(ORDER BY v1.orderID DESC) as row#\n"
            + "			FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "			)\n"
            + "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber\n"
            + "FROM subTable\n"
            + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_SEARCH_ORDER_ALL = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblOrder";
    private static final String SEARCH_ORDER = "WITH subTable AS (\n"
            + "			SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber, ROW_NUMBER() OVER(ORDER BY v1.orderID DESC) as row#\n"
            + "			FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "			WHERE (orderDate BETWEEN ? AND ?) AND statusID = ? AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'\n"
            + "			)\n"
            + "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber\n"
            + "FROM subTable\n"
            + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_SEARCH_ORDER = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID WHERE (orderDate BETWEEN ? AND ?) AND statusID = ? AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";
    private static final String SEARCH_ORDER_BY_DATE = "WITH subTable AS (\n"
            + "			SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber, ROW_NUMBER() OVER(ORDER BY v1.orderID DESC) as row# \n"
            + "			FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "			WHERE (orderDate BETWEEN ? AND ?) AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'\n"
            + "			)\n"
            + "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber\n"
            + "FROM subTable\n"
            + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_SEARCH_ORDER_BY_DATE = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID WHERE (orderDate BETWEEN ? AND ?) AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";
    private static final String SEARCH_ORDER_BY_STATUS = "WITH subTable AS (\n"
            + "			SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber, ROW_NUMBER() OVER(ORDER BY v1.orderID DESC) as row#  \n"
            + "                 FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "                 WHERE statusID = ? AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'\n"
            + "			)\n"
            + "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber\n"
            + "FROM subTable\n"
            + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_SEARCH_ORDER_BY_STATUS = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID AND statusID = ? AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";
    private static final String SEARCH_ORDER_BY_NAME = "WITH subTable AS (\n"
            + "			SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber, ROW_NUMBER() OVER(ORDER BY v1.orderID DESC) as row#  \n"
            + "			FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "                 WHERE [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'\n"
            + "			)\n"
            + "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber\n"
            + "FROM subTable\n"
            + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_SEARCH_ORDER_BY_NAME = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String GET_RETURNED_ORDER = "SELECT v1.orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber \n"
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "WHERE statusID = 8 AND userID LIKE ?";

    private static final String COUNT_ORDER_STATUS = "SELECT COUNT(statusID) AS numberOfStatus\n"
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "WHERE statusID = ?";
    //-------------------------------
    private int numberOfOrder;

    public int getNumberOfOrder() {
        return numberOfOrder;
    }

    //-------------------------------
    public int getOrderID(String userID) throws SQLException {
        int orderID = 0;

        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_ORDER_ID);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    orderID = rs.getInt("orderID");
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

        return orderID;
    }

    public List<OrderDetailDTO> getOrderDetail(int orderID) throws SQLException {
        List<OrderDetailDTO> list = new ArrayList<>();

        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(SEARCH_ORDER_DETAIL);
                stm.setInt(1, orderID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String productName = rs.getString("productName");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    String size = rs.getString("size");
                    String color = rs.getString("color");
                    int productID = rs.getInt("productID");
                    int orderDetailID = rs.getInt("detailID");
                    list.add(new OrderDetailDTO(orderDetailID, productName, productID, price, quantity, size, color));
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

        return list;
    }

    public List<OrderStatusDTO> getUpdateStatusHistory(int orderID) throws SQLException {
        List<OrderStatusDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDER_STATUS);
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int statusID = rs.getInt("statusID");
                    Timestamp updateDate = rs.getTimestamp("updateDate");
                    String statusName = rs.getString("statusName");
                    String modifiedBy = rs.getString("modifiedBy");
                    String roleID = rs.getString("roleID");
                    String userName = rs.getString("fullName");
                    list.add(new OrderStatusDTO(statusID, updateDate, statusName, modifiedBy, roleID, userName));
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
        return list;
    }

    public List<OrderDTO> getOrder(String search, String sDateFrom, String sDateTo, String sStatusID, int offset, int noOfProducts) throws SQLException {
        List<OrderDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if (!sDateFrom.isEmpty() && !sDateTo.isEmpty() && !sStatusID.isEmpty()) {
                    Date dateFrom = Date.valueOf(sDateFrom);
                    Date dateTo = Date.valueOf(sDateTo);
                    int statusID = Integer.parseInt(sStatusID);
                    ptm = conn.prepareStatement(SEARCH_ORDER);
                    ptm.setDate(1, dateFrom);
                    ptm.setDate(2, dateTo);
                    ptm.setInt(3, statusID);
                    ptm.setString(4, search);
                    ptm.setInt(5, offset);
                    ptm.setInt(6, noOfProducts);
                } else if (!sDateFrom.isEmpty() && !sDateTo.isEmpty() && sStatusID.isEmpty()) {
                    Date dateFrom = Date.valueOf(sDateFrom);
                    Date dateTo = Date.valueOf(sDateTo);
                    ptm = conn.prepareStatement(SEARCH_ORDER_BY_DATE);
                    ptm.setDate(1, dateFrom);
                    ptm.setDate(2, dateTo);
                    ptm.setString(3, search);
                    ptm.setInt(4, offset);
                    ptm.setInt(5, noOfProducts);
                } else if (!(!sDateFrom.isEmpty() && !sDateTo.isEmpty()) && !sStatusID.isEmpty()) {
                    int statusID = Integer.parseInt(sStatusID);
                    ptm = conn.prepareStatement(SEARCH_ORDER_BY_STATUS);
                    ptm.setInt(1, statusID);
                    ptm.setString(2, search);
                    ptm.setInt(3, offset);
                    ptm.setInt(4, noOfProducts);
                } else if ((sDateFrom.isEmpty() || sDateTo.isEmpty()) && sStatusID.isEmpty()) {
                    ptm = conn.prepareStatement(SEARCH_ORDER_BY_NAME);
                    ptm.setString(1, search);
                    ptm.setInt(2, offset);
                    ptm.setInt(3, noOfProducts);
                }
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    String userName = rs.getString("fullName");
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    int statusID = rs.getInt("statusID");
                    String statusName = rs.getString("statusName");
                    String payType = rs.getString("payType");
                    String trackingID = rs.getString("trackingID");
                    String fullName = rs.getString("orderFullName");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String note = rs.getString("note");
                    String transactionNumber = rs.getString("transactionNumber");
                    List<OrderDetailDTO> orderDetail = getOrderDetail(orderID);
                    List<OrderStatusDTO> orderStatus = getUpdateStatusHistory(orderID);

                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName, payType, trackingID, fullName, address, phone, email, note, transactionNumber, orderDetail, orderStatus));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                if (!sDateFrom.isEmpty() && !sDateTo.isEmpty() && !sStatusID.isEmpty()) {
                    Date dateFrom = Date.valueOf(sDateFrom);
                    Date dateTo = Date.valueOf(sDateTo);
                    int statusID = Integer.parseInt(sStatusID);
                    ptm = conn.prepareStatement(NUMBER_OF_SEARCH_ORDER);
                    ptm.setDate(1, dateFrom);
                    ptm.setDate(2, dateTo);
                    ptm.setInt(3, statusID);
                    ptm.setString(4, search);
                } else if (!sDateFrom.isEmpty() && !sDateTo.isEmpty() && sStatusID.isEmpty()) {
                    Date dateFrom = Date.valueOf(sDateFrom);
                    Date dateTo = Date.valueOf(sDateTo);
                    ptm = conn.prepareStatement(NUMBER_OF_SEARCH_ORDER_BY_DATE);
                    ptm.setDate(1, dateFrom);
                    ptm.setDate(2, dateTo);
                    ptm.setString(3, search);
                } else if (!(!sDateFrom.isEmpty() && !sDateTo.isEmpty()) && !sStatusID.isEmpty()) {
                    int statusID = Integer.parseInt(sStatusID);
                    ptm = conn.prepareStatement(NUMBER_OF_SEARCH_ORDER_BY_STATUS);
                    ptm.setInt(1, statusID);
                    ptm.setString(2, search);
                } else if ((sDateFrom.isEmpty() || sDateTo.isEmpty()) && sStatusID.isEmpty()) {
                    ptm = conn.prepareStatement(NUMBER_OF_SEARCH_ORDER_BY_NAME);
                    ptm.setString(1, search);
                }
                rs = ptm.executeQuery();
                if (rs.next()) {
                    this.numberOfOrder = rs.getInt("ROW_COUNT");
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
//        Collections.reverse(list);
        return list;

    }

    public boolean updateOrderStatus(int orderID, int statusID, String userID, String roleID) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        /**
         * - Chưa xác nhận: hệ thống - Đã xác nhận: manager/employee - Đang
         * giao: manager - Đã giao: manager - Đã huỷ: manager tự chuyển/ hệ
         * thống chuyển; chỉ áp dụng với trường hợp COD. - Nếu trả trước (online
         * banking):khi huỷ chuyển thành Chờ hoàn tiền: he thong chuyen, manager
         * chuyen - Sau khi hoàn tiền online, manager chuyển thành Da hoan tien.
         *
         * - Chỉ có thể huỷ khi Chưa xác nhận.
         */
        try {
            List<OrderStatusDTO> list = getUpdateStatusHistory(orderID);
            int currentStatusID = list.get(list.size() - 1).getStatusID();
            boolean isValidStatus = false;
            if (currentStatusID == 1) {
                if (statusID > currentStatusID) {
                    isValidStatus = true;
                }
            } else {
                if (!(currentStatusID == 5 || currentStatusID == 7)) {
                    if (statusID > currentStatusID && statusID < 5) {
                        isValidStatus = true;
                    }
                }
                if (currentStatusID == 6 && statusID == 7) {
                    isValidStatus = true;
                }
                if (currentStatusID == 3 && statusID == 5) {
                    isValidStatus = true;
                }
            }
            if (isValidStatus) {
                conn = DBUtils.getConnection();
                if (conn != null) {
                    ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);
                    ptm.setInt(1, statusID);
                    ptm.setInt(2, orderID);
                    ptm.setString(3, userID);
                    ptm.setString(4, roleID);
                    result = ptm.executeUpdate() > 0;
                }
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

    public boolean updateOrderTrackingID(int orderID, String trackingID, boolean allowDuplicateTrackingId) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if (!allowDuplicateTrackingId) {
                    String currentTrackingID = "";
                    ptm = conn.prepareStatement(GET_ORDER_TRACKING_ID);
                    ptm.setInt(1, orderID);
                    rs = ptm.executeQuery();
                    if (rs.next()) {
                        currentTrackingID = rs.getString("trackingID") == null ? "" : rs.getString("trackingID");
                    }
                    if (!currentTrackingID.equalsIgnoreCase(trackingID)) {
                        ptm = conn.prepareStatement(UPDATE_TRACKINGID);
                        ptm.setString(1, trackingID);
                        ptm.setInt(2, orderID);

                        check = ptm.executeUpdate() > 0;
                    }
                } else {
                    ptm = conn.prepareStatement(UPDATE_TRACKINGID);
                    ptm.setString(1, trackingID);
                    ptm.setInt(2, orderID);

                    check = ptm.executeUpdate() > 0;
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
        return check;
    }

    public List<OrderDTO> getAllOrder(int offset, int noOfProducts) throws SQLException {
        List<OrderDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDER_ALL);
                ptm.setInt(1, offset);
                ptm.setInt(2, noOfProducts);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    String userName = rs.getString("fullName");
                    int statusID = rs.getInt("statusID");
                    String statusName = rs.getString("statusName");
                    String payType = rs.getString("payType");
                    String trackingID = rs.getString("trackingID");
                    String fullName = rs.getString("orderFullName");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String note = rs.getString("note");
                    String transactionNumber = rs.getString("transactionNumber");
                    List<OrderDetailDTO> orderDetail = getOrderDetail(orderID);
                    List<OrderStatusDTO> orderStatus = getUpdateStatusHistory(orderID);

                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName, payType, trackingID, fullName, address, phone, email, note, transactionNumber, orderDetail, orderStatus));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                ptm = conn.prepareStatement(NUMBER_OF_SEARCH_ORDER_ALL);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    this.numberOfOrder = rs.getInt("ROW_COUNT");
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
//        Collections.reverse(list);
        return list;
    }

    public boolean addOrder(OrderDTO order, String userID, List<CartProduct> cart) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            // insert Order
            ptm = conn.prepareStatement(INSERT_ORDER);
            ptm.setDate(1, Date.valueOf(LocalDate.now()));
            ptm.setInt(2, order.getTotal());
            ptm.setString(3, userID);
            ptm.setString(4, order.getPayType());
            ptm.setString(5, order.getFullName());
            ptm.setString(6, order.getAddress());
            ptm.setString(7, order.getPhone());
            ptm.setString(8, order.getEmail());
            ptm.setString(9, order.getNote());
            ptm.setString(10, order.getTransactionNumber());
            check = ptm.executeUpdate() > 0;
            if (check) {
                // get new orderID
                ptm = conn.prepareStatement(GET_ORDER_ID);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    boolean orderDetailCheck = true;
                    // insert orderDetail
                    for (CartProduct item : cart) {
                        ptm = conn.prepareStatement(INSERT_ORDER_DETAIL);
                        ptm.setInt(1, item.getPrice() - item.getDiscount());
                        ptm.setInt(2, item.getQuantity());
                        ptm.setString(3, item.getSize());
                        ptm.setString(4, item.getColor());
                        ptm.setInt(5, orderID);
                        ptm.setInt(6, item.getProductID());
                        orderDetailCheck = orderDetailCheck && ptm.executeUpdate() > 0;
                        if (!orderDetailCheck) {
                            throw new SQLException("Fail to insert orderDetail");// use throw exception cause i don't know if break; can catch exception to do rollback();
                        }
                    }
                    // update orderStatus
                    if (orderDetailCheck) {
                        ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);
                        ptm.setInt(1, 1); // set statusID = 1 as new order always come with status = 1
                        ptm.setInt(2, orderID);
                        ptm.setString(3, "System");
                        ptm.setString(4, "");
                        check = ptm.executeUpdate() > 0;
                    }

                }

            }
            // check if insert successfully
            if (check) {
                conn.commit();
            } else {
                throw new SQLException("Fail to insert order");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }

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

    public List<Pair<OrderDTO, List<OrderDetailDTO>>> getOrderHistory(String userID) throws SQLException {
        List<Pair<OrderDTO, List<OrderDetailDTO>>> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_ORDER_HISTORY);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    String payType = rs.getString("payType");
                    String statusName = rs.getString("statusName");

                    list.add(new Pair(new OrderDTO(orderID, orderDate, total, statusName, payType), new ArrayList<OrderDTO>()));
                }

                for (int i = 0; i < list.size(); i++) {
                    ptm = conn.prepareStatement(GET_ORDER_DETAIL);
                    ptm.setInt(1, list.get(i).getKey().getOrderID());
                    rs = ptm.executeQuery();
                    while (rs.next()) {
                        int productID = rs.getInt("productID");
                        String productName = rs.getString("productName");
                        int price = rs.getInt("price");
                        int quantity = rs.getInt("quantity");
                        String size = rs.getString("size");
                        String color = rs.getString("color");
                        String image = rs.getString("image");

                        list.get(i).getValue().add(new OrderDetailDTO(productID, productName, price, quantity, size, color, image));
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
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

    public Pair<OrderDTO, List<OrderDetailDTO>> getOrderDetails(int orderID) throws SQLException {
        Pair<OrderDTO, List<OrderDetailDTO>> order = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                Map<Integer, String> status = new HashMap<>();

                ptm = conn.prepareStatement(GET_STATUS_HISTORY);
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int statusID = rs.getInt("statusID");
                    Timestamp updateDate = rs.getTimestamp("updateDate");
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                    status.put(statusID, sdf.format(updateDate));
                }
                ptm = conn.prepareStatement(GET_ORDER);
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    String fullName = rs.getString("fullName");
                    int statusID = rs.getInt("statusID");
                    String statusName = rs.getString("statusName");
                    String payType = rs.getString("payType");
                    String trackingID = rs.getString("trackingID");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String note = rs.getString("note");

                    order = new Pair(new OrderDTO(orderID, orderDate, total, statusID, statusName, payType, trackingID, fullName, address, phone, email, note, status), new ArrayList<OrderDTO>());
                }

                if (order != null) {
                    ptm = conn.prepareStatement(GET_ORDER_DETAIL);
                    ptm.setInt(1, order.getKey().getOrderID());
                    rs = ptm.executeQuery();
                    while (rs.next()) {
                        int detailID = rs.getInt("detailID");
                        int productID = rs.getInt("productID");
                        String productName = rs.getString("productName");
                        int price = rs.getInt("price");
                        int quantity = rs.getInt("quantity");
                        String size = rs.getString("size");
                        String color = rs.getString("color");
                        String image = rs.getString("image");
                        String returnStatus = rs.getString("returnType");
                        String note = rs.getString("note");

                        order.getValue().add(new OrderDetailDTO(detailID, productID, productName, price, quantity, size, color, image, returnStatus, note));
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
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
        return order;
    }

    public boolean updateOrderStatus(int orderID, int statusID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);

            ptm.setInt(1, statusID);
            ptm.setInt(2, orderID);
            ptm.setString(3, "System");
            ptm.setString(4, "");

            check = ptm.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException e) {
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

    public boolean refundProduct(int orderID, int detailID, int oldQuantity, int newQuantity, String modifiedBy, String roleID, int maxQuantity, int price, String note) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            if (oldQuantity >= newQuantity) {
                //update lại quantity 
                ptm = conn.prepareStatement(UPDATE_ORDER_DETAIL);
                ptm.setInt(1, newQuantity);
                ptm.setInt(2, detailID);
                boolean check = ptm.executeUpdate() > 0;
                //insert sản phẩm đổi

                //insert tblReturn
                if (check) {
                    ptm = conn.prepareStatement(INSERT_ORDER_RETURN);
                    ptm.setInt(1, detailID);
                    ptm.setInt(2, oldQuantity - newQuantity);
                    ptm.setString(3, "Trả");
                    ptm.setString(4, note);
                    check = ptm.executeUpdate() > 0;
                    //update tblOrderStatus
                    if (check) {
                        check = updateOrderReturnStatus(orderID, 8, modifiedBy, roleID);
                        if (check) {
                            ptm = conn.prepareStatement(UPDATE_ORDER_TOTAL);
                            ptm.setInt(1, getOrderTotal(orderID) - (oldQuantity - newQuantity) * price);
                            ptm.setInt(2, orderID);
                            result = ptm.executeUpdate() > 0;
                        }
                    }
                }

            }
            if (result) {
                conn.commit();
            }
        } catch (ClassNotFoundException | SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException e2) {
            }
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

    public int getOrderTotal(int orderID) throws SQLException {
        int result = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_ORDER_TOTAL);
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    result = rs.getInt("total");
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
        return result;
    }

    public List<ReturnDTO> getOrderReturnHistory(int orderID) throws SQLException {
        List<ReturnDTO> list = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_RETURN_HISTORY);
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productName = rs.getString("productName");
                    int price = rs.getInt("price");
                    String size = rs.getString("size");
                    String color = rs.getString("color");
                    String returnQuantity = rs.getString("returnQuantity");
                    String returnType = rs.getString("returnType");
                    Date returnDate = rs.getDate("returnDate");
                    String note = rs.getString("note");

                    list.add(new ReturnDTO(productName, price, size, color, returnQuantity, returnType, returnDate, note));
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
        return list;
    }

    public boolean updateOrderReturnStatus(int orderID, int statusID, String modifiedBy, String roleID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);

            ptm.setInt(1, statusID);
            ptm.setInt(2, orderID);
            ptm.setString(3, modifiedBy);
            ptm.setString(4, roleID);

            check = ptm.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException e) {
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

    public OrderDTO getOrder(int orderID) throws SQLException {
        OrderDTO order = new OrderDTO();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDER_BY_ID);
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    String userName = rs.getString("fullName");
                    String userID = rs.getString("userID");
                    int statusID = rs.getInt("statusID");
                    String statusName = rs.getString("statusName");
                    String payType = rs.getString("payType");
                    String trackingID = rs.getString("trackingID");
                    String fullName = rs.getString("orderFullName");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String note = rs.getString("note");
                    String transactionNumber = rs.getString("transactionNumber");
                    List<OrderDetailDTO> orderDetail = getOrderDetail(orderID);
                    List<OrderStatusDTO> orderStatus = getUpdateStatusHistory(orderID);

                    order = new OrderDTO(orderID, orderDate, total, userID, userName, statusID, statusName, payType, trackingID, fullName, address, phone, email, note, transactionNumber, orderDetail, orderStatus);
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
        return order;
    }

    public boolean returnProduct(int orderID, int detailID, int oldQuantity, int newQuantity, CartProduct itemOld, CartProduct itemNew, String modifiedBy, String roleID, int maxQuantity, String note) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            if (newQuantity >= 0) {
                //update lại quantity 
                ptm = conn.prepareStatement(UPDATE_ORDER_DETAIL);
                ptm.setInt(1, newQuantity);
                ptm.setInt(2, detailID);
                boolean check = ptm.executeUpdate() > 0;
                //insert sản phẩm đổi
                if (check && itemNew.getQuantity() <= maxQuantity) {
                    //đã có sản phẩm cùng loại trong order --> tăng quantity
                    List<Integer> detailIdQuantity = new ArrayList();
                    ptm = conn.prepareStatement(CHECK_ORDER_DUPLICATE_ITEM);
                    ptm.setInt(1, orderID);
                    ptm.setInt(2, itemNew.getProductID());
                    ptm.setString(3, itemNew.getColor());
                    ptm.setString(4, itemNew.getSize());
                    rs = ptm.executeQuery();
                    while (rs.next()) {
                        detailIdQuantity.add(rs.getInt("detailID"));
                        detailIdQuantity.add(rs.getInt("quantity"));
                    }

                    if (detailIdQuantity.size() > 0) {
                        ptm = conn.prepareStatement(UPDATE_ORDER_DETAIL);
                        ptm.setInt(1, detailIdQuantity.get(1) + itemNew.getQuantity());
                        ptm.setInt(2, detailIdQuantity.get(0));
                        check = ptm.executeUpdate() > 0;
                    } else {
                        //insert mới
                        ptm = conn.prepareStatement(INSERT_ORDER_DETAIL);
                        ptm.setInt(1, itemNew.getPrice());
                        ptm.setInt(2, itemNew.getQuantity());
                        ptm.setString(3, itemNew.getSize());
                        ptm.setString(4, itemNew.getColor());
                        ptm.setInt(5, orderID);
                        ptm.setInt(6, itemNew.getProductID());
                        check = ptm.executeUpdate() > 0;
                    }
                    //insert tblReturn
                    if (check) {
                        ptm = conn.prepareStatement(INSERT_ORDER_RETURN);
                        ptm.setInt(1, detailID);
                        ptm.setInt(2, oldQuantity - newQuantity);
                        ptm.setString(3, "Đổi");
                        ptm.setString(4, note);
                        check = ptm.executeUpdate() > 0;
                        //update tblOrderStatus
                        if (check) {
                            result = updateOrderReturnStatus(orderID, 8, modifiedBy, roleID);
                        }
                    }
                }

                //k xoá detailID, chỉ chỉnh quantity về 0; insert new detail
                //insert return tbl, chỉnh order status
            }
            if (result) {
                conn.commit();
            }
        } catch (ClassNotFoundException | SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException e2) {
            }
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

    public List<OrderDTO> getReturnedOrder(String userID) throws SQLException {
        List<OrderDTO> list = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_RETURNED_ORDER);
            ptm.setString(1, userID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                int orderID = rs.getInt("orderID");
                String userName = rs.getString("fullName");
                Date orderDate = rs.getDate("orderDate");
                int total = rs.getInt("total");
                int statusID = rs.getInt("statusID");
                String statusName = rs.getString("statusName");
                String payType = rs.getString("payType");
                String trackingID = rs.getString("trackingID");
                String fullName = rs.getString("orderFullName");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String note = rs.getString("note");
                String transactionNumber = rs.getString("transactionNumber");
                List<OrderDetailDTO> orderDetail = getOrderDetail(orderID);
                List<OrderStatusDTO> orderStatus = getUpdateStatusHistory(orderID);

                list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName, payType, trackingID, fullName, address, phone, email, note, transactionNumber, orderDetail, orderStatus));

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
    public int countStatus(int statusID) throws SQLException {
        int result = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(COUNT_ORDER_STATUS);
            ptm.setInt(1, statusID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                result = rs.getInt("numberOfStatus");
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
        return result;
    }
}
