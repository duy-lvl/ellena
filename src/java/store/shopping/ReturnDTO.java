package store.shopping;

import java.sql.Date;

/**
 *
 * @author DuyLVL
 */
public class ReturnDTO {
    private String productName;
    private int price;
    private String size;
    private String color;
    private String returnQuantity;
    private String returnType;
    private Date returnDate;
    private String note;

    public ReturnDTO() {
    }

    public ReturnDTO(String productName, int price, String size, String color, String returnQuantity, String returnType, Date returnDate, String note) {
        this.productName = productName;
        this.price = price;
        this.size = size;
        this.color = color;
        this.returnQuantity = returnQuantity;
        this.returnType = returnType;
        this.returnDate = returnDate;
        this.note = note;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getReturnQuantity() {
        return returnQuantity;
    }

    public void setReturnQuantity(String returnQuantity) {
        this.returnQuantity = returnQuantity;
    }

    public String getReturnType() {
        return returnType;
    }

    public void setReturnType(String returnType) {
        this.returnType = returnType;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
    
}
