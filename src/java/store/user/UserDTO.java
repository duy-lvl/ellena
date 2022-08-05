/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.user;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author giama
 */
public class UserDTO {
    private String userID;
    private String fullName;
    private String password;
    private boolean sex;
    private String roleID;
    private String address;
    private Date   birthday;
    private String phone;
    private boolean status;   
    
    public UserDTO() {
        this.userID = "";
        this.fullName = "";
        this.password = "";
        this.sex = false;
        this.roleID = "";
        this.address = "";
        this.birthday = null;
        this.phone = "";
        this.status = false;
    }
    
    //return history constructor
    public UserDTO(String userID, String fullName, boolean sex, String address, String phone) {
        this.userID = userID;
        this.fullName = fullName;
        this.sex = sex;
        this.address = address;
        this.phone = phone;
    }
    
    public UserDTO(String userID, String fullName, String password, boolean sex, String roleID, String address, Date birthday, String phone, boolean status) {
        this.userID = userID;
        this.fullName = fullName;
        this.password = password;
        this.sex = sex;
        this.roleID = roleID;
        this.address = address;
        this.birthday = birthday;
        this.phone = phone;
        this.status = status;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean getSex() {
        return sex;
    }

    public void setSex(boolean sex) {
        this.sex = sex;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
 
    
}
