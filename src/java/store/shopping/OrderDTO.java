package store.shopping;

import java.sql.Date;
import java.util.List;
import java.util.Map;

public class OrderDTO {

    private int orderID;
    private Date orderDate;
    private int total;
    private String userID;
    private String userName;
    private int statusID;
    private String statusName;
    private String payType;
    private String trackingID;
    private String fullName;
    private String address;
    private String phone;
    private String email;
    private String note;
    private String transactionNumber;
    private Map<Integer, String> status;
    private List<OrderDetailDTO> orderDetail;
    private List<OrderStatusDTO> updateStatusHistory;

    public OrderDTO() {
    }

    public OrderDTO(int orderID, Date orderDate, int total, String userName, int statusID, String statusName, String payType, String trackingID, String fullName, String address, String phone, String email, String note, String transactionNumber, List<OrderDetailDTO> orderDetail, List<OrderStatusDTO> updateStatusHistory) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.userName = userName;
        this.statusID = statusID;
        this.statusName = statusName;
        this.payType = payType;
        this.trackingID = trackingID;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.note = note;
        this.transactionNumber = transactionNumber;
        this.orderDetail = orderDetail;
        this.updateStatusHistory = updateStatusHistory;
    }
    
    public OrderDTO(int orderID, Date orderDate, int total, String userID, String userName, int statusID, String statusName, String payType, String trackingID, String fullName, String address, String phone, String email, String note, String transactionNumber, List<OrderDetailDTO> orderDetail, List<OrderStatusDTO> updateStatusHistory) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.userID = userID;
        this.userName = userName;
        this.statusID = statusID;
        this.statusName = statusName;
        this.payType = payType;
        this.trackingID = trackingID;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.note = note;
        this.transactionNumber = transactionNumber;
        this.orderDetail = orderDetail;
        this.updateStatusHistory = updateStatusHistory;
    }

    public OrderDTO(int orderID, Date orderDate, int total, String statusName, String payType) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.statusName = statusName;
        this.payType = payType;
    }

    // constructor for Manager-order/Employee-order 
    public OrderDTO(int orderID, Date orderDate, int total, String userName, int statusID, String statusName, String payType, String trackingID) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.userName = userName;
        this.statusID = statusID;
        this.statusName = statusName;
        this.payType = payType;
        this.trackingID = trackingID;
    }
    
   

    // normal constructor with no orderID, trackingID
    public OrderDTO(Date orderDate, int total, String userName, int statusID, String statusName, String payType, String fullName, String address, String phone, String email, String note, String transactionNumber) {
        this.orderDate = orderDate;
        this.total = total;
        this.userName = userName;
        this.statusID = statusID;
        this.statusName = statusName;
        this.payType = payType;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.note = note;
        this.transactionNumber = transactionNumber;
    }

    // contructor for customer order details
    public OrderDTO(int orderID, Date orderDate, int total, int statusID, String statusName, String payType, String trackingID, String fullName, String address, String phone, String email, String note, Map<Integer, String> status) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.statusID = statusID;
        this.statusName = statusName;
        this.payType = payType;
        this.trackingID = trackingID;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.note = note;
        this.status = status;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    
    
    public Map<Integer, String> getStatus() {
        return status;
    }

    public void setStatus(Map<Integer, String> status) {
        this.status = status;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getTrackingID() {
        return trackingID;
    }

    public void setTrackingID(String trackingID) {
        this.trackingID = trackingID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getTransactionNumber() {
        return transactionNumber;
    }

    public void setTransactionNumber(String transactionNumber) {
        this.transactionNumber = transactionNumber;
    }

    public List<OrderDetailDTO> getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(List<OrderDetailDTO> orderDetail) {
        this.orderDetail = orderDetail;
    }

    public List<OrderStatusDTO> getUpdateStatusHistory() {
        return updateStatusHistory;
    }

    public void setUpdateStatusHistory(List<OrderStatusDTO> updateStatusHistory) {
        this.updateStatusHistory = updateStatusHistory;
    }

    public String getStatus(int statusID) {
        String result = "";
        switch (statusID) {
            case 1: 
                result = "Chưa xác nhận";
                break;
            case 2: 
                result = "Đã xác nhận";
                break;
            case 3: 
                result = "Đang giao";
                break;
            case 4: 
                result = "Đã giao";
                break;
            case 5: 
                result = "Đã hủy";
                break;
            case 6: 
                result = "Chờ hoàn tiền";
                break;
            case 7: 
                result = "Đã hoàn tiền";
                break;
            case 8: 
                result = "Đã đổi/trả";
                break;
        }
        return result;
    }
}
