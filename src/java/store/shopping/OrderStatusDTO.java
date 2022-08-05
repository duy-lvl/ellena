package store.shopping;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class OrderStatusDTO {

    private int statusID;
    private Timestamp updateDate;
    private String statusName;
    private String userID;
    private String roleID;
    private String userName;

    public OrderStatusDTO() {
    }

    public OrderStatusDTO(int statusID, Timestamp updateDate, String statusName, String userID, String roleID, String userName) {
        this.statusID = statusID;
        this.updateDate = updateDate;
        this.statusName = statusName;
        this.userID = userID;
        this.roleID = roleID;
        this.userName = userName;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getUpdateDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        return sdf.format(updateDate);
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

}
