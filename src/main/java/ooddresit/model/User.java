/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ooddresit.model;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;
import javax.persistence.Embedded;

/**
 *
 * @author brank
 */
public class User {

    private Long id;

    private String username = "";

    private String firstName = "";

    private String secondName = "";

    private Address address;
    
    private String password = "";

    private String hashedPassword = "";

    private double balance; //instance variable

    private UserRole userRole;

    private Boolean enabled = true;
    
    private static Long lastInt = 0L;
   

    public User(String userName, String password) {
        this.id = lastInt++;
        lastInt = this.id;
        this.username = userName;
        this.password = password;
        this.balance = 0d;
        this.userRole = UserRole.CUSTOMER;
    }
    
      public User(String userName, String password, UserRole userrole) {
        this.id = lastInt++;
        lastInt = this.id;
        this.username = userName;
        this.password = password;
        this.balance = 0d;
        this.userRole = userrole;
           }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public void reduceBalance(double basketCost){
        double userBalance = this.getBalance();
        if (userBalance < basketCost) {
            System.out.println("User does not have enough funds to purchase basket");
        } else {
            this.setBalance(userBalance - basketCost);
        }
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSecondName() {
        return secondName;
    }

    public void setSecondName(String secondName) {
        this.secondName = secondName;
    }

    @Embedded
    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword;
    }
    
    

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public UserRole getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }
    
    public double getBalance() {
        return balance;
    }
    
    public void setBalance(double balance) {
        this.balance = balance;
    }
    

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", firstName=" + firstName + ", secondName=" + secondName + ", username=" + username + ", password=NOT SHOWN, address=" + address + ", userRole=" + userRole + ", balance=" + balance + '}';

    }
}
