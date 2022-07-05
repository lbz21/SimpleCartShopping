/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ooddresit.model;

import java.util.UUID;

/**
 *
 * @author cgallen / nickw
 */
// Product class
// Represents a single product sold by the shop
// Each product has an ID, a name, a manufacturer, a price, and a current 
// quantity in stock.
// TODO you need to complete this class
public class Product {

    private UUID id;
    private String name; //productType;

    private String productType;
    private double price;
    private int qtyInStock;
    private int currentQtyInBasket;
    
    public Product() {}
    
    public Product(String name, String productType, double price, int qtyInStock){
        id = UUID.randomUUID();
        this.name = name;
        this.productType = productType;
        this.price = price;
        this.qtyInStock = qtyInStock;
        this.currentQtyInBasket = 1;
    }
   
    public String getId() {
        return this.id.toString();
    }

    public String getName() {
        return name;
    }
    
    public int getCurrentQty() {
        return this.currentQtyInBasket;
    }
    
    public void setCurrentQty() {
        this.currentQtyInBasket++;
    }
    
    public void resetCurrentQty()
    {
        this.currentQtyInBasket = 1;
    }

    public void setName(String name) {
        this.name = name;
    }


    public void setproductType(String prodType) {
        this.productType = prodType;
    }

    public String getPrice() {
        return String.format("%.2f", price);
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public int qtyInStock() {
        return qtyInStock;
    }
    
    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public int getQtyInStock() {
        return qtyInStock;
    }

    public void setQtyInStock(int qtyInStock) {
        this.qtyInStock = qtyInStock;
    }
    
    public void getAvailableItems() {}
    
     @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", productType=" + productType + ", price=" + price + ", qtyInStock=" + qtyInStock + '}'; 

}
}
//public void 

