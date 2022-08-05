/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.user;

/**
 *
 * @author giama
 */
public class UserError {
    private String userID;
    private String fullName;
    private String password;
    private String confirm;
    
    private String errorMessage;

    public UserError() {
        this.userID = "";
        this.fullName = "";
        this.password = "";
        this.confirm = "";
        this.errorMessage = "";
    }

    public UserError(String userID, String fullName, String password, String confirm, String errorMessage) {
        this.userID = userID;
        this.fullName = fullName;
        this.password = password;
        this.confirm = confirm;
        this.errorMessage = errorMessage;
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

    public String getConfirm() {
        return confirm;
    }

    public void setConfirm(String confirm) {
        this.confirm = confirm;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
    
    
}
