package store.shopping;

import java.util.List;
import java.util.Map;

public class ProductDTO {

    private int productID;
    private String productName;
    private String description;
    private Map<String, List<String>> colorImage;
    private Map<List<String>, Integer> colorSizeQuantity;
    private int price;
    private int quantity;
    private int discount;
    private int lowStockLimit;
    private String categoryName;
    private boolean status;
    private int categoryID;

        
    public ProductDTO() {

    }

    public ProductDTO(int productID, String productName, String description, Map<String, List<String>> colorImage, Map<List<String>, Integer> colorSizeQuantity, int price, int discount, int lowStockLimit, boolean status, int categoryID) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.colorImage = colorImage;
        this.colorSizeQuantity = colorSizeQuantity;
        this.price = price;
        this.discount = discount;
        this.lowStockLimit = lowStockLimit;
        this.status = status;
        this.categoryID = categoryID;
    }

    public ProductDTO(int productID, String productName, String description, int price, int discount, int lowStockLimit, boolean status, int categoryID) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.lowStockLimit = lowStockLimit;
        this.status = status;
        this.categoryID = categoryID;
    }

    public ProductDTO(int productID, String productName, String description, Map<String, List<String>> colorImage, int price, int quantity, int discount, int lowStockLimit, String categoryName, boolean status) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.colorImage = colorImage;
        this.price = price;
        this.quantity = quantity;
        this.discount = discount;
        this.lowStockLimit = lowStockLimit;
        this.categoryName = categoryName;
        this.status = status;
    }

    public ProductDTO(int productID, String productName, int price, int discount, int lowStockLimit, String categoryName, boolean status) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.discount = discount;
        this.lowStockLimit = lowStockLimit;
        this.categoryName = categoryName;
        this.status = status;
    }

    public ProductDTO(int productID, String productName, String description, Map<String, List<String>> colorImage, Map<List<String>, Integer> colorSizeQuantity, int price, int quantity, int discount, int lowStockLimit, String categoryName, boolean status) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.colorImage = colorImage;
        this.colorSizeQuantity = colorSizeQuantity;
        this.price = price;
        this.quantity = quantity;
        this.discount = discount;
        this.lowStockLimit = lowStockLimit;
        this.categoryName = categoryName;
        this.status = status;
    }

    public ProductDTO(int productID, String productName, Map<List<String>, Integer> colorSizeQuantity, int quantity, int lowStockLimit) {
        this.productID = productID;
        this.productName = productName;
        this.colorSizeQuantity = colorSizeQuantity;
        this.quantity = quantity;
        this.lowStockLimit = lowStockLimit;
    }

    
    
    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Map<String, List<String>> getColorImage() {
        return colorImage;
    }

    public void setColorImage(Map<String, List<String>> colorImage) {
        this.colorImage = colorImage;
    }

    public Map<List<String>, Integer> getColorSizeQuantity() {
        return colorSizeQuantity;
    }

    public void setColorSizeQuantity(Map<List<String>, Integer> colorSizeQuantity) {
        this.colorSizeQuantity = colorSizeQuantity;
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

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
