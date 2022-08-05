package store.shopping;

public class OrderDetailDTO {

    private int orderDetailID;
    private String productName;
    private int productID;
    private int price;
    private int quantity;
    private String size;
    private String color;
    private String image;
    private String returnStatus;
    private String note;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(int orderDetailID, String productName, int productID, int price, int quantity, String size, String color) {
        this.orderDetailID = orderDetailID;
        this.productName = productName;
        this.productID = productID;
        this.price = price;
        this.quantity = quantity;
        this.size = size;
        this.color = color;
    }

    public OrderDetailDTO(String productName, int price, int quantity, String size, String color) {
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.size = size;
        this.color = color;
    }
    
    public OrderDetailDTO(int productID, String productName, int price, int quantity, String size, String color, String image) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.size = size;
        this.color = color;
        this.image = image;
    }

    public OrderDetailDTO(int detailID,int productID, String productName, int price, int quantity, String size, String color, String image, String returnStatus, String note) {
        this.orderDetailID = detailID;
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.size = size;
        this.color = color;
        this.image = image;
        this.returnStatus = returnStatus;
        this.note = note;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    
    
    public String getReturnStatus() {
        return returnStatus;
    }

    public void setReturnStatus(String returnStatus) {
        this.returnStatus = returnStatus;
    }

    
    
    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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

}
