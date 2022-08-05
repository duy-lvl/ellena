/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.shopping;

public class StatisticDTO {
    protected Integer orderQuantity; 
    protected Integer income; 
    protected Integer productQuantity; 

    public StatisticDTO(Integer orderQuantity, Integer income, Integer productQuantity) {
        this.orderQuantity = orderQuantity;
        this.income = income;
        this.productQuantity = productQuantity;
    }

    
    public Integer getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(Integer orderQuantity) {
        this.orderQuantity = orderQuantity;
    }

    public Integer getIncome() {
        return income;
    }

    public void setIncome(Integer income) {
        this.income = income;
    }

    public Integer getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(Integer productQuantity) {
        this.productQuantity = productQuantity;
    }

   
    
}
