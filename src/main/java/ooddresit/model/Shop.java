/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ooddresit.model;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nick
 */
// Class representing the shop as a whole
// Contains methods for retrieving products by name, by ID, etc.
// TODO you need to complete this class
public class Shop {

    private static User currentUser;

    static List<User> userList = new ArrayList();

    static List<Product> shoppingCart = new ArrayList();
    static List<Product> productList = new ArrayList();

    public void before() {
        userList.add(new User("user1", "pass"));
        userList.add(new User("user2", "pass"));
        userList.add(new User("user1", "pass"));
        userList.add(new User("admin", "admin", UserRole.ADMINISTRATOR));

        userList.get(0).setBalance(100000);

        Product testProduct = new Product("XPS_15", "Laptop", 300d, 100);

        productList.add(testProduct);
        productList.add(new Product("Fiesta", "Car", 30000d, 50));
        productList.add(new Product("Macbook_15", "Laptop", 1500d, 90));
        productList.add(new Product("Apple_Watch_40mm_Gold", "Watch", 300d, 600));

        shoppingCartTotal();
    }

    public List<Product> getAvailableItems() {
        return productList;
    }

    public void addProduct(Product newProduct) {
        productList.add(newProduct);
    }

    public List<Product> getSearchByProductName(String productName) {
        List<Product> productsAvaliableByProductName = new ArrayList();
        for (Product item : getAvailableItems()) {
            if (item.getName().equalsIgnoreCase(productName)) {
                productsAvaliableByProductName.add(item);
            }
        }
        return productsAvaliableByProductName;
    }

    public List<Product> getSearchByProductType(String productType) {
        List<Product> productsAvaliableByProductType = new ArrayList();

        for (Product item : getAvailableItems()) {
            if (item.getProductType().equalsIgnoreCase(productType)) {
                productsAvaliableByProductType.add(item);
            }
        }
        return productsAvaliableByProductType;
    }

    public Product searchByProductName(String itemName) {
        for (Product item : getAvailableItems()) {
            if (item.getName().equalsIgnoreCase(itemName)) {
                return item;
            }
        }
        return null;
    }

    public static List<User> userListInitialiser() {
//       
//        userList.add(1L, "default", "pass", 11.12, UserRole.ADMINISTRATOR);
//        user.add(new User(2L, "customer", "pass", 11.12, UserRole.CUSTOMER));

        return userList;
    }

    public void addItemToCart(Product item) {
        shoppingCart.add(item);
    }

    public static List<Product> getShoppingCart() {
        return shoppingCart;
    }

    public void clearBasket() {
        for (Product item : getAvailableItems()) {
            item.resetCurrentQty();
        }

        shoppingCart = new ArrayList();
    }

    public boolean reduceQtyWhenPurchased() {

        for (Product itemsToPurchase : getShoppingCart()) {
            for (Product itemsAvaliable : getAvailableItems()) {
                if (itemsToPurchase.getId().equals(itemsAvaliable.getId())) {
                    if (itemsAvaliable.getQtyInStock() - itemsToPurchase.getCurrentQty() < 0) {
                        System.out.println("Quantity in basket is more than quantity left in stock.");
                        return false;
                    } else {
                        itemsAvaliable.setQtyInStock(itemsAvaliable.getQtyInStock() - itemsToPurchase.getCurrentQty());

                        return true;
                    }

                }
            }
        }
        return false;
    }

    public static String shoppingCartTotal() {
        double cost = 0d;

        for (Product item : getShoppingCart()) {
            if (item.getCurrentQty() == 1) {
                cost += Double.parseDouble(item.getPrice());
            } else {
                for (int i = 0; i < item.getCurrentQty(); i++) {
                    cost += Double.parseDouble(item.getPrice());
                }
            }
        }
        return String.format("%.2f", cost);
    }

    public Product getNewItemByName(String name) {
        String newName = "";

        for (Product item : this.getAvailableItems()) {

            if (item.getName().equals(name)) {
                return item;
            }
        }
        return null;
    }

    public void setCurrentUser(User user) {
        currentUser = user;
    }

    public User getCurrentUser() {
        return currentUser;
    }

    public void addUser(User user) {
        userList.add(user);
    }

    public User userExists(String username, String password) {
        for (User user : userList) {
            if ((user.getUsername().equals(username)) && (user.getPassword().equals(password))) {
                return user;
            }
        }
        return null;
    }
}
