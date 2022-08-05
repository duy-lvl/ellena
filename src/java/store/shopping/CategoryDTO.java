
package store.shopping;

public class CategoryDTO {
    private int categoryID;
    private String categoryName;
    private int order;
    private boolean status;

    public CategoryDTO() {
    }

    public CategoryDTO(String categoryName, int order, boolean status) {
        this.categoryName = categoryName;
        this.order = order;
        this.status = status;
    }

    public CategoryDTO(int categoryID, String categoryName, int order, boolean status) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.order = order;
        this.status = status;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
}
