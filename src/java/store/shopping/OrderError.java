/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package store.shopping;

/**
 *
 * @author ASUS
 */
public class OrderError {
    private String orderID;
    private String orderDate;
    private String total;
    private String userName;
    private String statusID;
    private String statusName;
    private String payType;
    private String trackingID;
    private String fullName;
    private String address;
    private String shippingProvinces;
    private String phone;
    private String email;
    private String note;
    private String transactionNumber;

    public OrderError() {
        this.orderID = "";
        this.orderDate = "";
        this.total = "";
        this.userName = "";
        this.statusID = "";
        this.statusName = "";
        this.payType = "";
        this.trackingID = "";
        this.fullName = "";
        this.address = "";
        this.shippingProvinces = "";
        this.phone = "";
        this.email = "";
        this.note = "";
        this.transactionNumber = "";
    }

    public OrderError(String orderID, String orderDate, String total, String userName, String statusID, String statusName, String payType, String trackingID, String fullName, String address, String shippingProvinces, String phone, String email, String note, String transactionNumber) {
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
        this.shippingProvinces = shippingProvinces;
        this.phone = phone;
        this.email = email;
        this.note = note;
        this.transactionNumber = transactionNumber;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getStatusID() {
        return statusID;
    }

    public void setStatusID(String statusID) {
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

    public String getShippingProvinces() {
        return shippingProvinces;
    }

    public void setShippingProvinces(String shippingProvinces) {
        this.shippingProvinces = shippingProvinces;
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

    
    
    
    
    
    
    
    
    
}
