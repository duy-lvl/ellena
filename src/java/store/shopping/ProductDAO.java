package store.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javafx.util.Pair;
import store.utils.DBUtils;

public class ProductDAO {

    private static final String ACTIVATE_PRODUCT = "UPDATE tblProduct SET status=1 WHERE productID=?";
    private static final String DEACTIVATE_PRODUCT = "UPDATE tblProduct SET status=0 WHERE productID=?";
    private static final String GET_PRODUCT = "SELECT productID, productName, price, description, categoryName, discount, lowStockLimit, p.status  FROM tblProduct p JOIN tblCategory c ON p.categoryID=c.categoryID AND productID=?";
    private static final String GET_PRODUCT_COLOR_IMAGES = "SELECT color, image\n"
            + "FROM tblProduct p JOIN tblProductColors pc\n"
            + "ON p.productID = pc.productID \n"
            + "AND p.productID = ?\n"
            + "JOIN tblColorImage ci\n"
            + "ON ci.productColorID = pc.productColorID";
    private static final String GET_PRODUCT_COLOR_SIZES = "SELECT color, size, quantity\n"
            + "FROM tblProduct p JOIN tblProductColors pc \n"
            + "ON p.productID = pc.productID \n"
            + "AND p.productID = ?\n"
            + "JOIN tblColorSizes cs\n"
            + "ON cs.productColorID = pc.productColorID";
    private static final String GET_TREND_LIST = "SELECT p.productID, p.productName, p.price, p.discount, i.image\n"
            + "            FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID \n"
            + "            JOIN tblColorImage i ON pc.productColorID = i.productColorID\n"
            + "            INNER JOIN tblOrderDetail d ON p.productID = d.productID \n"
            + "            JOIN tblOrder o ON d.orderID = o.orderID  \n"
            + "            WHERE DATEDIFF(day,o.orderDate,GETDATE()) < 30 AND p.status = 1\n"
            + "            GROUP BY p.productID, p.productName, p.price, p.discount, i.image\n"
            + "            ORDER BY SUM(d.quantity) desc";
    private static final String GET_BEST_SELLER_LIST = "SELECT p.productID, p.productName, p.price, p.discount, i.image\n"
            + "FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID \n"
            + "JOIN tblColorImage i ON pc.productColorID = i.productColorID\n"
            + "JOIN tblOrderDetail d ON p.productID = d.productID \n"
            + "JOIN tblOrder o ON d.orderID = o.orderID\n"
            + "WHERE  p.status = 1\n"
            + "GROUP BY p.productID, p.productName, p.price, p.discount, i.image\n"
            + "ORDER BY SUM(d.quantity) desc";
    private static final String GET_SALE_LIST = "SELECT p.productID, p.productName, p.price, p.discount, i.image\n"
            + "            FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID \n"
            + "            JOIN tblColorImage i ON pc.productColorID = i.productColorID\n"
            + "            JOIN tblOrderDetail d ON p.productID = d.productID \n"
            + "            JOIN tblOrder o ON d.orderID = o.orderID\n"
            + "            WHERE  p.status = 1 AND p.discount <> 0\n"
            + "            GROUP BY p.productID, p.productName, p.price, p.discount, i.image\n"
            + "            ORDER BY p.discount desc";
    private static final String GET_NEW_ARRIVAL_LIST = "SELECT p.productID, p.productName, p.price, p.discount, i.image\n"
            + "FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID \n"
            + "JOIN tblColorImage i ON pc.productColorID = i.productColorID\n"
            + "WHERE p.productID in (SELECT TOP 20 productID FROM tblProduct ORDER BY productID desc) AND p.status = 1\n"
            + "ORDER BY p.productID desc";
    private static final String GET_SEARCH_CATALOG = "SELECT p.productID, p.productName, p.price, p.discount, i.image, color, size\n"
            + "FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID\n"
            + "JOIN tblColorImage i ON pc.productColorID = i.productColorID\n"
            + "JOIN tblColorSizes cs ON cs.productColorID = pc.productColorID\n"
            + "JOIN tblCategory c ON c.categoryID = p.categoryID\n"
            + "WHERE dbo.fuChuyenCoDauThanhKhongDau(p.productName) LIKE ?\n"
            + "AND c.status =1";
    private static final String DELETE_IMAGE = "DELETE FROM tblColorImage WHERE image=?";
    private static final String INSERT_PRODUCT = "INSERT INTO tblProduct(productName, description, price, categoryID, discount, lowStockLimit, status) VALUES(?, ?, ?, ?, ?, ?, ?)";
    private static final String INSERT_PRODUCT_COLORS = "INSERT INTO tblProductColors(productID, color) VALUES(?, ?)";
    private static final String GET_PRODUCT_COLORS = "SELECT color FROM tblProductColors WHERE productID=?";
    private static final String GET_PRODUCT_IDENTITY = "SELECT IDENT_CURRENT('tblProduct')";
    private static final String GET_PRODUCT_COLOR_IDENTITY = "SELECT IDENT_CURRENT('tblProductColors')";
    private static final String INSERT_COLOR_IMAGES = "INSERT INTO tblColorImage(productColorID, image) VALUES(?, ?)";
    private static final String INSERT_COLOR_SIZES = "INSERT INTO tblColorSizes(productColorID, size, quantity) VALUES(?, ?, ?)";
    private static final String GET_NUMBER_OF_RATINGS = "SELECT COUNT(star) AS numberOfRatings FROM tblRating r JOIN tblProduct p ON r.productID = p.productID AND p.productID = ? GROUP BY p.productID";
    private static final String GET_EACH_STAR_SUM = "SELECT star, COUNT(star) AS numberOfStarRating FROM tblRating r JOIN tblProduct p ON r.productID = p.productID AND p.productID = ? GROUP BY star";
    private static final String CHECK_SIZE_QUANTITY = "SELECT size, quantity FROM tblProduct p JOIN tblProductColors pc \n"
            + "ON p.productID = pc.productID AND p.productID=? AND color LIKE ?\n"
            + "JOIN tblColorSizes cs ON cs.productColorID = pc.productColorID";
    private static final String DELETE_COLOR = "DELETE FROM tblColorImage WHERE productColorID=?;\n"
            + "DELETE FROM tblColorSizes WHERE productColorID=?;\n"
            + "DELETE FROM tblProductColors WHERE productColorID=?;\n";
    private static final String DELETE_SIZE = "DELETE FROM tblColorSizes WHERE productColorID=? AND size=?";
    private static final String UPDATE_SIZES_QUANTITY = "UPDATE tblColorSizes SET quantity = ? WHERE productColorID = ? AND size = ? ";
    private static final String UPDATE_PRODUCT = "UPDATE tblProduct SET productName=?, description=?, price=?, categoryID=?, discount=?, lowStockLimit=?, status=? WHERE productID=?";
    private static final String GET_PRODUCT_COLOR_ID_LIST = "SELECT productColorID FROM tblProductColors WHERE productID = ?";
    private static final String UPDATE_IMAGES = "UPDATE tblColorImage SET image=? WHERE image=?";
    private static final String GET_PRODUCT_BY_CATEGORY = "SELECT p.productID, p.productName, p.price, p.discount, i.image, color, size\n"
            + "FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID\n"
            + "JOIN tblColorImage i ON pc.productColorID = i.productColorID\n"
            + "JOIN tblColorSizes cs ON cs.productColorID = pc.productColorID\n"
            + "JOIN tblCategory c ON c.categoryID = p.categoryID\n"
            + "WHERE dbo.fuChuyenCoDauThanhKhongDau(categoryName) LIKE ? AND c.status=1";

    private static final String UPDATE_PRODUCT_QUANTITY = "UPDATE tblColorSizes SET quantity = ? WHERE productColorID = ? AND size LIKE ?";
    private static final String GET_PRODUCTCOLORID = "SELECT pc.productColorID, color FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID WHERE p.productID = ? AND color LIKE ?";
    private static final String GET_PRODUCT_STATUS = "SELECT [status] FROM tblProduct WHERE productID = ?";
    private static final String SEARCH_ALL_PRODUCT = "WITH subTable AS (\n"
            + "			SELECT productID, productName, price, categoryName, discount, lowStockLimit, p.status, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as row#\n"
            + "			FROM tblProduct p JOIN tblCategory c ON p.categoryID=c.categoryID\n"
            + "			)\n"
            + "SELECT productID, productName, price, categoryName, discount, lowStockLimit, status\n"
            + "FROM subTable\n"
            + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_ALL_PRODUCT = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblProduct";
    private static final String SEARCH_PRODUCT = "WITH subTable AS (\n"
            + "			SELECT productID, productName, price, categoryName, discount, lowStockLimit, p.status, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as row#\n"
            + "			FROM tblProduct p JOIN tblCategory c ON p.categoryID=c.categoryID AND dbo.fuChuyenCoDauThanhKhongDau(productName) LIKE ?\n"
            + "			)\n"
            + "SELECT productID, productName, price, categoryName, discount, lowStockLimit, status\n"
            + "FROM subTable\n"
            + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_SEARCH_PRODUCT = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblProduct WHERE dbo.fuChuyenCoDauThanhKhongDau(productName) LIKE ?";
    private static final String SEARCH_PRODUCT_WITH_STATUS = "WITH subTable AS (\n"
            + "			SELECT productID, productName, price, categoryName, discount, lowStockLimit, p.status, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as row#\n"
            + "			FROM tblProduct p JOIN tblCategory c ON p.categoryID=c.categoryID AND dbo.fuChuyenCoDauThanhKhongDau(productName) LIKE ? AND p.status=?\n"
            + "			)\n"
            + "SELECT productID, productName, price, categoryName, discount, lowStockLimit, status\n"
            + "FROM subTable\n"
            + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_SEARCH_PRODUCT_WITH_STATUS = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblProduct WHERE dbo.fuChuyenCoDauThanhKhongDau(productName) LIKE ? AND status=?";
    private static final String GET_SEARCH_CATALOG_PAGINATION = "WITH subTable AS (\n"
            + "			SELECT p.productID, p.productName, p.price, p.discount, i.image, color, size, DENSE_RANK() OVER(ORDER BY p.productID) AS row#  \n"
            + "			FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID \n"
            + "			JOIN tblColorImage i ON pc.productColorID = i.productColorID\n"
            + "			JOIN tblColorSizes cs ON cs.productColorID = pc.productColorID\n"
            + "                 JOIN tblCategory c ON c.categoryID = p.categoryID"
            + "			WHERE dbo.fuChuyenCoDauThanhKhongDau(p.productName) LIKE ? AND p.status=1 AND c.status=1\n"
            + "			)\n"
            + "SELECT productID, productName, price, discount, image, color, size\n"
            + "FROM subTable\n"
            + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_GET_SEARCH_CATALOG_PAGINATION = "SELECT TOP 1 DENSE_RANK() OVER(ORDER BY p.productID) AS ROW_COUNT\n"
            + "FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID \n"
            + "JOIN tblColorImage i ON pc.productColorID = i.productColorID\n"
            + "JOIN tblColorSizes cs ON cs.productColorID = pc.productColorID\n"
            + "JOIN tblCategory c ON c.categoryID = p.categoryID\n"
            + "WHERE dbo.fuChuyenCoDauThanhKhongDau(p.productName) LIKE ? AND c.status=1 AND p.status=1\n"
            + "ORDER BY ROW_COUNT DESC";
    private static final String GET_LOW_STOCK_LIMIT_PRODUCT = "SELECT p.productID, p.productName, pc.color, cs.size, p.lowStockLimit, cs.quantity\n"
            + "FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID \n"
            + "JOIN tblColorSizes cs ON pc.productColorID = cs.productColorID\n"
            + "WHERE cs.quantity <= p.lowStockLimit AND p.status = 1";

    //-------------------------------
    private int numberOfProduct;

    public int getNumberOfProduct() {
        return numberOfProduct;
    }

    //-------------------------------
    public int getProductStatus(int productID) throws SQLException {
        int status = -1;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT_STATUS);
                ptm.setInt(1, productID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    status = rs.getInt("status");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return status;
    }

    public boolean updateProductQuantity(int quantity, int productColorID, String size) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_PRODUCT_QUANTITY);
                ptm.setInt(1, quantity);
                ptm.setInt(2, productColorID);
                ptm.setString(3, size);
                result = ptm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return result;
    }

    public int getProductColorID(int productID, String color) throws SQLException {
        int colorSizeID = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCTCOLORID);
                ptm.setInt(1, productID);
                ptm.setString(2, color);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    colorSizeID = rs.getInt("productColorID");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return colorSizeID;
    }

    public List<ProductDTO> getAllProduct(int offset, int noOfProducts) throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ALL_PRODUCT);
                ptm.setInt(1, offset);
                ptm.setInt(2, noOfProducts);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("productID");
                    String productName = rs.getString("productName");
                    int price = rs.getInt("price");
                    int discount = rs.getInt("discount");
                    String categoryName = rs.getString("categoryName");
                    int lowStockLimit = rs.getInt("lowStockLimit");
                    boolean status = rs.getBoolean("status");
                    listProduct.add(new ProductDTO(productID, productName, price, discount, lowStockLimit, categoryName, status));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                ptm = conn.prepareStatement(NUMBER_OF_ALL_PRODUCT);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    this.numberOfProduct = rs.getInt("ROW_COUNT");
                }
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return listProduct;
    }

    public int[] getProductRatingInfo(int productID) throws SQLException {
        int[] ratingDetails = new int[2]; //first index is average star, second index is number of ratings
        int numberOfStarRating;
        int star;
        int totalStarSum = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_NUMBER_OF_RATINGS);
                ptm.setInt(1, productID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    ratingDetails[1] = rs.getInt("numberOfRatings");
                }
                ptm = conn.prepareStatement(GET_EACH_STAR_SUM);
                ptm.setInt(1, productID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    numberOfStarRating = rs.getInt("numberOfStarRating");
                    star = rs.getInt("star");
                    totalStarSum += star * numberOfStarRating;
                }
                if (ratingDetails[1] != 0) {
                    ratingDetails[0] = totalStarSum / ratingDetails[1];
                } else {
                    ratingDetails[0] = 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return ratingDetails;
    }

    public ArrayList<Pair<String, Integer>> checkSizeQuantity(int productID, String color) throws SQLException {
        ArrayList<Pair<String, Integer>> sizeQuantityList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_SIZE_QUANTITY);
                ptm.setInt(1, productID);
                ptm.setString(2, color);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String size = rs.getString("size");
                    int quantity = rs.getInt("quantity");
                    sizeQuantityList.add(new Pair<>(size, quantity));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return sizeQuantityList;
    }

    public List<ProductDTO> getListProduct(String search, String Status, int offset, int noOfProducts) throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if ("true".equalsIgnoreCase(Status) || "false".equalsIgnoreCase(Status)) {
                    ptm = conn.prepareStatement(SEARCH_PRODUCT_WITH_STATUS);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, Status);
                    ptm.setInt(3, offset);
                    ptm.setInt(4, noOfProducts);
                } else {
                    ptm = conn.prepareStatement(SEARCH_PRODUCT);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setInt(2, offset);
                    ptm.setInt(3, noOfProducts);
                }
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("productID");
                    String productName = rs.getString("productName");
                    int price = rs.getInt("price");
                    int discount = rs.getInt("discount");
                    String categoryName = rs.getString("categoryName");
                    int lowStockLimit = rs.getInt("lowStockLimit");
                    boolean status = rs.getBoolean("status");
                    listProduct.add(new ProductDTO(productID, productName, price, discount, lowStockLimit, categoryName, status));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                if ("true".equalsIgnoreCase(Status) || "false".equalsIgnoreCase(Status)) {
                    ptm = conn.prepareStatement(NUMBER_OF_SEARCH_PRODUCT_WITH_STATUS);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, Status);
                } else {
                    ptm = conn.prepareStatement(NUMBER_OF_SEARCH_PRODUCT);
                    ptm.setString(1, "%" + search + "%");
                }

                rs = ptm.executeQuery();
                if (rs.next()) {
                    this.numberOfProduct = rs.getInt("ROW_COUNT");
                }
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return listProduct;
    }

    public boolean activateProduct(int productID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(ACTIVATE_PRODUCT);
            ptm.setInt(1, productID);

            check = ptm.executeUpdate() > 0 ? true : false;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deactivateProduct(int productID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(DEACTIVATE_PRODUCT);
            ptm.setInt(1, productID);

            check = ptm.executeUpdate() > 0 ? true : false;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public ProductDTO getProductDetail(int productID) throws SQLException {
        ProductDTO product = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT);
                ptm.setInt(1, productID);
                rs = ptm.executeQuery();
                String productName = "";
                String description = "";
                int price = 0;
                Map<String, List<String>> colorImage = new HashMap<>();
                Map<List<String>, Integer> colorSizeQuantity = new HashMap<>();
                int discount = 0;
                String categoryName = "";
                int lowStockLimit = 0;
                boolean status = true;
                if (rs.next()) {
                    productName = rs.getString("productName");
                    description = rs.getString("description");
                    price = rs.getInt("price");
                    discount = rs.getInt("discount");
                    categoryName = rs.getString("categoryName");
                    lowStockLimit = rs.getInt("lowStockLimit");
                    status = rs.getBoolean("status");
                }
                ptm = conn.prepareStatement(GET_PRODUCT_COLORS);
                ptm.setInt(1, productID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String color = rs.getString("color");
                    colorImage.put(color, new ArrayList<>());
                }
                ptm = conn.prepareStatement(GET_PRODUCT_COLOR_IMAGES);
                ptm.setInt(1, productID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String color = rs.getString("color");
                    String image = rs.getString("image");
                    colorImage.get(color).add(image);

                }

                ptm = conn.prepareStatement(GET_PRODUCT_COLOR_SIZES);
                ptm.setInt(1, productID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String color = rs.getString("color");
                    String size = rs.getString("size");
                    int quantity = rs.getInt("quantity");
                    colorSizeQuantity.put(Arrays.asList(color, size), quantity);

                }
                if (!productName.equals("")) {
                    product = new ProductDTO(productID, productName, description, colorImage, colorSizeQuantity, price, price, discount, lowStockLimit, categoryName, status);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return product;
    }

    public List<ProductDTO> getTrendList() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_TREND_LIST);
                rs = ptm.executeQuery();
                int productID = 0;
                String productName = "";
                int price = 0;
                int discount = 0;
                Map<String, List<String>> image = new HashMap<>();
                List<String> listImage = new ArrayList<>();

                while (rs.next()) {

                    int tempProductID = rs.getInt("productID");
                    String tempProductName = rs.getString("productName");
                    int tempPrice = rs.getInt("price");
                    int tempDiscount = rs.getInt("discount");
                    String tempImage = rs.getString("image");
                    if (tempProductID != productID) {
                        if (productID != 0) {
                            image.put("key", listImage);
                            ProductDTO product = new ProductDTO(productID, productName, "", image, new HashMap<List<String>, Integer>(), price, 0, discount, 0, "", false);
                            list.add(product);
                        }
                        image = new HashMap<>();
                        listImage = new ArrayList<>();
                        listImage.add(tempImage);
                        productID = tempProductID;
                        productName = tempProductName;
                        price = tempPrice;
                        discount = tempDiscount;
                    } else {
                        listImage.add(tempImage);
                    }

                }
                if (productID != 0) {
                    image.put("key", listImage);
                    ProductDTO product = new ProductDTO(productID, productName, "", image, new HashMap<List<String>, Integer>(), price, 0, discount, 0, "", false);
                    list.add(product);
                }

            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    public List<ProductDTO> getBestSellerList() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_BEST_SELLER_LIST);
                rs = ptm.executeQuery();
                int productID = 0;
                String productName = "";
                int price = 0;
                int discount = 0;
                Map<String, List<String>> image = new HashMap<>();
                List<String> listImage = new ArrayList<>();

                while (rs.next()) {

                    int tempProductID = rs.getInt("productID");
                    String tempProductName = rs.getString("productName");
                    int tempPrice = rs.getInt("price");
                    int tempDiscount = rs.getInt("discount");
                    String tempImage = rs.getString("image");
                    if (tempProductID != productID) {
                        if (productID != 0) {
                            image.put("key", listImage);
                            ProductDTO product = new ProductDTO(productID, productName, "", image, new HashMap<List<String>, Integer>(), price, 0, discount, 0, "", false);
                            list.add(product);
                        }
                        image = new HashMap<>();
                        listImage = new ArrayList<>();
                        listImage.add(tempImage);
                        productID = tempProductID;
                        productName = tempProductName;
                        price = tempPrice;
                        discount = tempDiscount;
                    } else {
                        listImage.add(tempImage);
                    }

                }
                if (productID != 0) {
                    image.put("key", listImage);
                    ProductDTO product = new ProductDTO(productID, productName, "", image, new HashMap<List<String>, Integer>(), price, 0, discount, 0, "", false);
                    list.add(product);
                }

            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    public List<ProductDTO> getSaleList() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_SALE_LIST);
                rs = ptm.executeQuery();
                int productID = 0;
                String productName = "";
                int price = 0;
                int discount = 0;
                Map<String, List<String>> image = new HashMap<>();
                List<String> listImage = new ArrayList<>();

                while (rs.next()) {

                    int tempProductID = rs.getInt("productID");
                    String tempProductName = rs.getString("productName");
                    int tempPrice = rs.getInt("price");
                    int tempDiscount = rs.getInt("discount");
                    String tempImage = rs.getString("image");
                    if (tempProductID != productID) {
                        if (productID != 0) {
                            image.put("key", listImage);
                            ProductDTO product = new ProductDTO(productID, productName, "", image, new HashMap<List<String>, Integer>(), price, 0, discount, 0, "", false);
                            list.add(product);
                        }
                        image = new HashMap<>();
                        listImage = new ArrayList<>();
                        listImage.add(tempImage);
                        productID = tempProductID;
                        productName = tempProductName;
                        price = tempPrice;
                        discount = tempDiscount;
                    } else {
                        listImage.add(tempImage);
                    }

                }
                if (productID != 0) {
                    image.put("key", listImage);
                    ProductDTO product = new ProductDTO(productID, productName, "", image, new HashMap<List<String>, Integer>(), price, 0, discount, 0, "", false);
                    list.add(product);
                }

            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    public List<ProductDTO> getNewArrivalList() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_NEW_ARRIVAL_LIST);
                rs = ptm.executeQuery();
                int productID = 0;
                String productName = "";
                int price = 0;
                int discount = 0;
                Map<String, List<String>> image = new HashMap<>();
                List<String> listImage = new ArrayList<>();

                while (rs.next()) {

                    int tempProductID = rs.getInt("productID");
                    String tempProductName = rs.getString("productName");
                    int tempPrice = rs.getInt("price");
                    int tempDiscount = rs.getInt("discount");
                    String tempImage = rs.getString("image");
                    if (tempProductID != productID) {
                        if (productID != 0) {
                            image.put("key", listImage);
                            ProductDTO product = new ProductDTO(productID, productName, "", image, new HashMap<List<String>, Integer>(), price, 0, discount, 0, "", false);
                            list.add(product);
                        }
                        image = new HashMap<>();
                        listImage = new ArrayList<>();
                        listImage.add(tempImage);
                        productID = tempProductID;
                        productName = tempProductName;
                        price = tempPrice;
                        discount = tempDiscount;
                    } else {
                        listImage.add(tempImage);
                    }

                }
                if (productID != 0) {
                    image.put("key", listImage);
                    ProductDTO product = new ProductDTO(productID, productName, "", image, new HashMap<List<String>, Integer>(), price, 0, discount, 0, "", false);
                    list.add(product);
                }

            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    public List<ProductDTO> getSearchCatalogPagination(String search, int offset, int noOfProducts) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_SEARCH_CATALOG_PAGINATION);
                ptm.setString(1, "%" + search + "%");
                ptm.setInt(2, offset);
                ptm.setInt(3, noOfProducts);
                rs = ptm.executeQuery();
                int productID = 0;
                String productName = "";
                int price = 0;
                int discount = 0;
                Map<String, List<String>> image = new HashMap<>();
                List<String> listImage = new ArrayList<>();
                HashMap<List<String>, Integer> colorSizeQuantity = new HashMap<>();
                List<String> colorSize = new ArrayList<>();
                while (rs.next()) {

                    int tempProductID = rs.getInt("productID");
                    String tempProductName = rs.getString("productName");
                    int tempPrice = rs.getInt("price");
                    int tempDiscount = rs.getInt("discount");
                    String tempImage = rs.getString("image");
                    String tempColor = rs.getString("color");
                    String tempSize = rs.getString("size");
                    if (tempProductID != productID) {
                        if (productID != 0) {
                            image.put("key", listImage);
                            colorSizeQuantity.put(colorSize, 1);
                            ProductDTO product = new ProductDTO(productID, productName, "", image, colorSizeQuantity, price, 0, discount, 0, "", false);
                            list.add(product);
                        }
                        image = new HashMap<>();
                        colorSizeQuantity = new HashMap<>();
                        listImage = new ArrayList<>();
                        colorSize = new ArrayList<>();
                        if (!listImage.contains(tempImage)) {
                            listImage.add(tempImage);
                        }
                        if (!colorSize.contains(tempColor)) {
                            colorSize.add(tempColor);
                        }
                        if (!colorSize.contains(tempSize)) {
                            colorSize.add(tempSize);
                        }

                        productID = tempProductID;
                        productName = tempProductName;
                        price = tempPrice;
                        discount = tempDiscount;
                    } else {
                        if (!listImage.contains(tempImage)) {
                            listImage.add(tempImage);
                        }

                        if (!colorSize.contains(tempColor)) {
                            colorSize.add(tempColor);
                        }
                        if (!colorSize.contains(tempSize)) {
                            colorSize.add(tempSize);
                        }

                    }

                }
                image.put("key", listImage);
                colorSizeQuantity.put(colorSize, 1);
                if (productID != 0) {
                    ProductDTO product = new ProductDTO(productID, productName, "", image, colorSizeQuantity, price, 0, discount, 0, "", false);
                    list.add(product);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                ptm = conn.prepareStatement(NUMBER_OF_GET_SEARCH_CATALOG_PAGINATION);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                if (rs.next()) {
                    this.numberOfProduct = rs.getInt("ROW_COUNT");
                }
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    public List<ProductDTO> getProductByCategory(String category) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT_BY_CATEGORY);
                ptm.setString(1, "%" + category + "%");
                rs = ptm.executeQuery();
                int productID = 0;
                String productName = "";
                int price = 0;
                int discount = 0;
                Map<String, List<String>> image = new HashMap<>();
                List<String> listImage = new ArrayList<>();
                HashMap<List<String>, Integer> colorSizeQuantity = new HashMap<>();
                List<String> colorSize = new ArrayList<>();
                while (rs.next()) {

                    int tempProductID = rs.getInt("productID");
                    String tempProductName = rs.getString("productName");
                    int tempPrice = rs.getInt("price");
                    int tempDiscount = rs.getInt("discount");
                    String tempImage = rs.getString("image");
                    String tempColor = rs.getString("color");
                    String tempSize = rs.getString("size");
                    if (tempProductID != productID) {
                        if (productID != 0) {
                            image.put("key", listImage);
                            colorSizeQuantity.put(colorSize, 1);
                            ProductDTO product = new ProductDTO(productID, productName, "", image, colorSizeQuantity, price, 0, discount, 0, "", false);
                            list.add(product);
                        }
                        image = new HashMap<>();
                        colorSizeQuantity = new HashMap<>();
                        listImage = new ArrayList<>();
                        colorSize = new ArrayList<>();
                        if (!listImage.contains(tempImage)) {
                            listImage.add(tempImage);
                        }
                        if (!colorSize.contains(tempColor)) {
                            colorSize.add(tempColor);
                        }
                        if (!colorSize.contains(tempSize)) {
                            colorSize.add(tempSize);
                        }

                        productID = tempProductID;
                        productName = tempProductName;
                        price = tempPrice;
                        discount = tempDiscount;
                    } else {
                        if (!listImage.contains(tempImage)) {
                            listImage.add(tempImage);
                        }

                        if (!colorSize.contains(tempColor)) {
                            colorSize.add(tempColor);
                        }
                        if (!colorSize.contains(tempSize)) {
                            colorSize.add(tempSize);
                        }

                    }

                }
                image.put("key", listImage);
                colorSizeQuantity.put(colorSize, 1);
                if (productID != 0) {
                    ProductDTO product = new ProductDTO(productID, productName, "", image, colorSizeQuantity, price, 0, discount, 0, "", false);
                    list.add(product);
                }

            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    public boolean deleteImage(String image) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(DELETE_IMAGE);
            ptm.setString(1, image);

            check = ptm.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean addProduct(ProductDTO product) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            ptm = conn.prepareStatement(INSERT_PRODUCT);
            ptm.setString(1, product.getProductName());
            ptm.setString(2, product.getDescription());
            ptm.setInt(3, product.getPrice());
            ptm.setInt(4, product.getCategoryID());
            ptm.setInt(5, product.getDiscount());
            ptm.setInt(6, product.getLowStockLimit());
            ptm.setBoolean(7, product.isStatus());
            check = ptm.executeUpdate() > 0;

            if (check) {
                ptm = conn.prepareStatement(GET_PRODUCT_IDENTITY);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int productID = rs.getInt(1);
                    for (String color : product.getColorImage().keySet()) {
                        ptm = conn.prepareStatement(INSERT_PRODUCT_COLORS);
                        ptm.setInt(1, productID);
                        ptm.setString(2, color);
                        check = ptm.executeUpdate() > 0;
                        if (check) {
                            ptm = conn.prepareStatement(GET_PRODUCT_COLOR_IDENTITY);
                            rs = ptm.executeQuery();
                            if (rs.next()) {
                                int productColorID = rs.getInt(1);
                                for (String image : product.getColorImage().get(color)) {
                                    ptm = conn.prepareStatement(INSERT_COLOR_IMAGES);
                                    ptm.setInt(1, productColorID);
                                    ptm.setString(2, image);
                                    check = ptm.executeUpdate() > 0;
                                    if (!check) {
                                        break;
                                    }
                                }
                                if (check) {
                                    for (List colorSize : product.getColorSizeQuantity().keySet()) {
                                        if (colorSize.get(0).equals(color)) {
                                            ptm = conn.prepareStatement(INSERT_COLOR_SIZES);
                                            ptm.setInt(1, productColorID);
                                            ptm.setString(2, colorSize.get(1).toString());
                                            ptm.setInt(3, product.getColorSizeQuantity().get(colorSize));
                                            check = ptm.executeUpdate() > 0;
                                            if (!check) {
                                                break;
                                            }
                                        }
                                    }
                                }

                            }
                        }
                    }
                }
            }

            conn.commit();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException se2) {
                se2.printStackTrace();
            }

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }

        }
        return check;
    }

    public boolean addImage(int productColorID, String image) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT_COLOR_IMAGES);
            ptm.setInt(1, productColorID);
            ptm.setString(2, image);

            check = ptm.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteColor(int productColorID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(DELETE_COLOR);
            ptm.setInt(1, productColorID);
            ptm.setInt(2, productColorID);
            ptm.setInt(3, productColorID);

            check = ptm.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean addColors(int productID, String[] colors) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            ptm = conn.prepareStatement(INSERT_PRODUCT_COLORS);
            for (String color : colors) {
                ptm.setInt(1, productID);
                ptm.setString(2, color.substring(0, 1).toUpperCase() + color.substring(1));
                ptm.addBatch();
            }

            int[] results = ptm.executeBatch();
            for (int i = 0; i < results.length; i++) {
                check = results[i] >= 0;
            }
            conn.commit();

        } catch (ClassNotFoundException | SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException se2) {
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteSize(int productColorID, String size) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(DELETE_SIZE);
            ptm.setInt(1, productColorID);
            ptm.setString(2, size);

            check = ptm.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean addVariants(int productColorID, String[] sizes, int[] quantities) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            ptm = conn.prepareStatement(INSERT_COLOR_SIZES);
            for (int i = 0; i < sizes.length; i++) {
                ptm.setInt(1, productColorID);
                ptm.setString(2, sizes[i].toUpperCase().trim());
                ptm.setInt(3, quantities[i]);
                ptm.addBatch();
            }

            int[] results = ptm.executeBatch();
            for (int i = 0; i < results.length; i++) {
                check = results[i] >= 0;
            }
            conn.commit();

        } catch (ClassNotFoundException | SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException se2) {
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean updateVariants(int productColorID, String[] sizes, int[] quantities) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            ptm = conn.prepareStatement(UPDATE_SIZES_QUANTITY);
            for (int i = 0; i < sizes.length; i++) {
                ptm.setInt(1, quantities[i]);
                ptm.setInt(2, productColorID);
                ptm.setString(3, sizes[i].toUpperCase());
                ptm.addBatch();
            }

            int[] results = ptm.executeBatch();
            for (int i = 0; i < results.length; i++) {
                check = results[i] >= 0;
            }
            conn.commit();

        } catch (ClassNotFoundException | SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException se2) {
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean updateProduct(ProductDTO product) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_PRODUCT);

            ptm.setString(1, product.getProductName());
            ptm.setString(2, product.getDescription());
            ptm.setInt(3, product.getPrice());
            ptm.setInt(4, product.getCategoryID());
            ptm.setInt(5, product.getDiscount());
            ptm.setInt(6, product.getLowStockLimit());
            ptm.setBoolean(7, product.isStatus());
            ptm.setInt(8, product.getProductID());

            check = ptm.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<Integer> getProductColorIDList(int productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<Integer> productColorIDs = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_PRODUCT_COLOR_ID_LIST);
            ptm.setInt(1, productID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                productColorIDs.add(rs.getInt(1));
            }

        } catch (ClassNotFoundException | SQLException e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return productColorIDs;
    }

    public List<String> getProductImages(List<Integer> productColorIDList) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<String> images = null;
        try {
            images = new ArrayList<>();
            conn = DBUtils.getConnection();
            StringBuilder sb = new StringBuilder("SELECT image FROM tblColorImage WHERE productColorID in (");
            productColorIDList.forEach((Integer _item) -> {
                sb.append("?, ");
            });
            sb.replace(sb.length() - 2, sb.length() - 1, ")");

            ptm = conn.prepareStatement(sb.toString());
            for (int i = 0; i < productColorIDList.size(); i++) {
                ptm.setInt(i + 1, productColorIDList.get(i));
            }

            rs = ptm.executeQuery();
            while (rs.next()) {
                images.add(rs.getString("image"));
            }

        } catch (ClassNotFoundException | SQLException e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return images;
    }

    public List<ProductDTO> getSearchCatalog(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_SEARCH_CATALOG);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                int productID = 0;
                String productName = "";
                int price = 0;
                int discount = 0;
                Map<String, List<String>> image = new HashMap<>();
                List<String> listImage = new ArrayList<>();
                HashMap<List<String>, Integer> colorSizeQuantity = new HashMap<>();
                List<String> colorSize = new ArrayList<>();
                while (rs.next()) {

                    int tempProductID = rs.getInt("productID");
                    String tempProductName = rs.getString("productName");
                    int tempPrice = rs.getInt("price");
                    int tempDiscount = rs.getInt("discount");
                    String tempImage = rs.getString("image");
                    String tempColor = rs.getString("color");
                    String tempSize = rs.getString("size");
                    if (tempProductID != productID) {
                        if (productID != 0) {
                            image.put("key", listImage);
                            colorSizeQuantity.put(colorSize, 1);
                            ProductDTO product = new ProductDTO(productID, productName, "", image, colorSizeQuantity, price, 0, discount, 0, "", false);
                            list.add(product);
                        }
                        image = new HashMap<>();
                        colorSizeQuantity = new HashMap<>();
                        listImage = new ArrayList<>();
                        colorSize = new ArrayList<>();
                        if (!listImage.contains(tempImage)) {
                            listImage.add(tempImage);
                        }
                        if (!colorSize.contains(tempColor)) {
                            colorSize.add(tempColor);
                        }
                        if (!colorSize.contains(tempSize)) {
                            colorSize.add(tempSize);
                        }

                        productID = tempProductID;
                        productName = tempProductName;
                        price = tempPrice;
                        discount = tempDiscount;
                    } else {
                        if (!listImage.contains(tempImage)) {
                            listImage.add(tempImage);
                        }

                        if (!colorSize.contains(tempColor)) {
                            colorSize.add(tempColor);
                        }
                        if (!colorSize.contains(tempSize)) {
                            colorSize.add(tempSize);
                        }

                    }

                }
                image.put("key", listImage);
                colorSizeQuantity.put(colorSize, 1);
                if (productID != 0) {
                    ProductDTO product = new ProductDTO(productID, productName, "", image, colorSizeQuantity, price, 0, discount, 0, "", false);
                    list.add(product);
                }

            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    public boolean updateImages(List<String> newImages, List<String> images) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            ptm = conn.prepareStatement(UPDATE_IMAGES);
            for (int i = 0; i < images.size(); i++) {
                ptm.setString(1, newImages.get(i));
                ptm.setString(2, images.get(i));
                ptm.addBatch();
            }

            int[] results = ptm.executeBatch();
            for (int i = 0; i < results.length; i++) {
                check = results[i] >= 0;
            }
            conn.commit();

        } catch (ClassNotFoundException | SQLException e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<ProductDTO> filterSearchedProducts(String search, int minAmount, int maxAmount, List<String> colors, List<String> sizes, int offset, int noOfProducts) throws SQLException {
        List<ProductDTO> filterOut = new ArrayList<>();
        List<ProductDTO> listProduct = getSearchCatalog(search);
        for (ProductDTO p : listProduct) {
            ProductDTO product = getProductDetail(p.getProductID());
            if (!(p.getPrice() - p.getDiscount() >= minAmount && p.getPrice() - p.getDiscount() <= maxAmount)) {
                filterOut.add(p);
            }
            if (!colors.isEmpty()) {
                boolean checkColor = false;
                for (String c : product.getColorImage().keySet()) {
                    if (colors.contains(c)) {
                        checkColor = true;
                        break;
                    }
                }
                if (!checkColor && !filterOut.contains(p)) {
                    filterOut.add(p);
                }
            }
            if (!sizes.isEmpty()) {
                boolean checkSize = false;
                Iterator<List<String>> it1 = product.getColorSizeQuantity().keySet().iterator();
                List<String> key = new ArrayList<>();
                while (it1.hasNext()) {
                    for (String n : it1.next()) {
                        key.add(n);
                    }
                }

                for (int a = 0; a < key.size(); a += 2) {
                    if (sizes.contains(key.get(a + 1))) {
                        checkSize = true;
                        break;
                    }
                }
                if (!checkSize && !filterOut.contains(p)) {
                    filterOut.add(p);
                }
            }

        }

        for (ProductDTO p : filterOut) {
            listProduct.remove(p);
        }

        List<ProductDTO> listProductPagination = new ArrayList<>();
        int index = 0;
        for (int i = offset; i <= noOfProducts; i++) {
//            listProductPagination.set(index, listProduct.get(i));
            if (i == listProduct.size()) {// prevent out of bound
                break;
            } else {
                listProductPagination.add(listProduct.get(i));
                index++;
            }
        }

        // number of product after filter out
        this.numberOfProduct = listProduct.size();

        return listProductPagination;
    }

    public List<ProductDTO> filterCategoryProducts(String category, int minAmount, int maxAmount, List<String> colors, List<String> sizes) throws SQLException {
        List<ProductDTO> filterOut = new ArrayList<>();
        List<ProductDTO> listProduct = getProductByCategory(category);
        for (ProductDTO p : listProduct) {
            ProductDTO product = getProductDetail(p.getProductID());
            if (!(p.getPrice() - p.getDiscount() >= minAmount && p.getPrice() - p.getDiscount() <= maxAmount)) {
                filterOut.add(p);
            }
            if (!colors.isEmpty()) {
                boolean checkColor = false;
                for (String c : product.getColorImage().keySet()) {
                    if (colors.contains(c)) {
                        checkColor = true;
                        break;
                    }
                }
                if (!checkColor && !filterOut.contains(p)) {
                    filterOut.add(p);
                }
            }
            if (!sizes.isEmpty()) {
                boolean checkSize = false;
                Iterator<List<String>> it1 = product.getColorSizeQuantity().keySet().iterator();
                List<String> key = new ArrayList<>();
                while (it1.hasNext()) {
                    for (String n : it1.next()) {
                        key.add(n);
                    }
                }

                for (int a = 0; a < key.size(); a += 2) {
                    if (sizes.contains(key.get(a + 1))) {
                        checkSize = true;
                        break;
                    }
                }
                if (!checkSize && !filterOut.contains(p)) {
                    filterOut.add(p);
                }
            }

        }

        for (ProductDTO p : filterOut) {
            listProduct.remove(p);
        }
        return listProduct;
    }

    public List<ProductDTO> getLowStockProduct() throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_LOW_STOCK_LIMIT_PRODUCT);
                rs = ptm.executeQuery();
                HashMap<List<String>, Integer> colorSizeQuantity = new HashMap<>();
                List<String> colorSize = new ArrayList<>();
                while (rs.next()) {
                    colorSizeQuantity = new HashMap<>();
                    colorSize = new ArrayList<>();
                    int productID = rs.getInt("productID");
                    String productName = rs.getString("productName");
                    String color = rs.getString("color");
                    String size = rs.getString("size");
                    int lowStockLimit = rs.getInt("lowStockLimit");
                    int quantity = rs.getInt("quantity");
                    colorSize.add(color);
                    colorSize.add(size);
                    colorSizeQuantity.put(colorSize, quantity);

                    listProduct.add(new ProductDTO(productID, productName, colorSizeQuantity, quantity, lowStockLimit));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return listProduct;
    }

}
