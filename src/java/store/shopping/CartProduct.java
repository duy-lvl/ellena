package store.shopping;

public class CartProduct {
    private int productID;
    private int sessionID;
    private String productName;
    private String color;
    private String image;
    private String size;
    private int price;
    private int quantity;
    private int discount;
    private int lowStockLimit;
    
    public CartProduct() {
    }

    public CartProduct(int productID, String color, String size, int price, int quantity) {
        this.productID = productID;
        this.color = color;
        this.size = size;
        this.price = price;
        this.quantity = quantity;
    }

    public CartProduct(int productID, int sessionID, int quantity, String size, String color) {
        this.productID = productID;
        this.sessionID = sessionID;
        this.quantity = quantity;
        this.size = size;
        this.color = color;
    }   

    public CartProduct(int productID, String color, String size) {
        this.productID = productID;
        this.color = color;
        this.size = size;
    }

    public CartProduct(int productID, String productName, String color, String image, String size, int price, int quantity, int discount, int lowStockLimit) {
        this.productID = productID;
        this.productName = productName;
        this.color = color;
        this.image = image;
        this.size = size;
        this.price = price;
        this.quantity = quantity;
        this.discount = discount;
        this.lowStockLimit = lowStockLimit;
    }

    public int getSessionID() {
        return sessionID;
    }

    public void setSessionID(int sessionID) {
        this.sessionID = sessionID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
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

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getLowStockLimit() {
        return lowStockLimit;
    }

    public void setLowStockLimit(int lowStockLimit) {
        this.lowStockLimit = lowStockLimit;
    }

    @Override
    public boolean equals(Object that) {
        return this.productID == ((CartProduct)that).productID
                && this.color.equalsIgnoreCase(((CartProduct)that).color)
                && this.size.equalsIgnoreCase(((CartProduct)that).size);
    }
    
    
}
