package store.shopping;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Cart {

    private int id;
    private String userID;
    private String fullName;
    private String phone;
    private String address;
    private String email;
    private String note;
    private String payType;

    private List<CartProduct> cartList = new ArrayList<>();

    public Cart() {
    }

    public Cart(int id, String userID, String fullName, String phone, String address, String email, String note, String payType) {
        this.id = id;
        this.userID = userID;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.email = email;
        this.note = note;
        this.payType = payType;
    }

    public CartProduct getProductInfo(int productID, String color, String sizeKey, int quantity) throws SQLException {
        CartProduct item = new CartProduct();
        ProductDAO dao = new ProductDAO();
        ProductDTO product = dao.getProductDetail(productID);
        item.setProductID(productID);
        item.setProductName(product.getProductName());
        item.setColor(color);
        item.setImage(product.getColorImage().get(color).get(0));
        item.setSize(sizeKey);
        item.setPrice(product.getPrice());
        item.setQuantity(quantity);
        item.setDiscount(product.getDiscount());
        item.setLowStockLimit(product.getLowStockLimit());

        return item;
    }

    public int getTotalAmount(List<CartProduct> cart) {
        int result = 0;
        for (CartProduct item : cart) {
            result += (item.getPrice() - item.getDiscount()) * item.getQuantity();
        }
        return result;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
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

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public List<CartProduct> getCartList() {
        return cartList;
    }

    public void setCartList(List<CartProduct> cartList) {
        this.cartList = cartList;
    }

}
