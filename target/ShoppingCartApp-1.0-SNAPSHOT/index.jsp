
<%@page import="ooddresit.model.UserRole"%>
<%@page import="ooddresit.model.Product"%>
<%@page import="ooddresit.model.User"%>
<%@page import="ooddresit.model.Shop"%>
<%-- 
    Document   : index
    Created on : 3 Oct 2021, 20:04:37
    Author     : nick
--%>


<%//@page import="freemap.com528.shoppingcartapp.dto.Cart"%>
<%//@page import="freemap.com528.shoppingcartapp.dto.Hit"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>

<head>
    <title>Start Page</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel='stylesheet' type='text/css' href='css/solentestores.css' />
    <link rel='stylesheet' type='text/css' href='css/bootstrap.min.css' />
    <link rel='stylesheet' type='text/css' href='css/navbar.css' />


</head>

<h1>Solent E-Stores</h1>

<p>The web app opens on the <a href="./index.jsp">Home Page</a></p>
<p>The web app opens on the <a href="./register.jsp">Create an account</a></p>
<p>The web app opens on the <a href="./login.jsp">Log In</a></p>
<p>The web app opens on the <a href="./profile.jsp">View Profile</a></p>

<br>
<%
    HttpSession currentSession = request.getSession();
    Shop shop;
    if (currentSession.getAttribute("shop") == null) {
        shop = new Shop();
        shop.before();
        currentSession.setAttribute("shop", shop);
    } else {
        shop = (Shop) currentSession.getAttribute("shop");
    }
    User currentUserValue = null;

    boolean currentUserIsAdmin = false;

    if (shop.getCurrentUser() != null) {
        currentUserValue = shop.getCurrentUser();
    }

    if (currentUserValue != null) {
%>
<p>Welcome to the shop user: <strong><%=currentUserValue.getUsername()%></strong></p>
<%
    if (shop.getCurrentUser().getUserRole() == UserRole.ADMINISTRATOR) {
%>
<p> User: <strong><%=currentUserValue.getUsername()%></strong> is an admin</p>
<%
        currentUserIsAdmin = true;
    }
} else { %>
<p><strong>You are not logged in</strong></p>
<%}
%>

<p>Welcome to Solent E-Stores, where you can buy all your favourite products!</p>

<table class="table">
    <tr>
    <form method="post" action="./index.jsp">
        <label for="productType">Search By Product type or name:</label><br />
        <input name="productType" type="text" placeholder="Search for name or cat..." /><br />
        <input type="hidden" name="action" value="search">
        <button type="submit" onclick="" >Search Item</button>
    </form>
</tr>
<h1><b>Avaliable Items to Shop:</b> </h1>

<%
    String productType = request.getParameter("productType");
    String oldProductType = "";
    if (currentSession.getAttribute("productType") == null) {
        currentSession.setAttribute("productType", productType);
    } else {
        oldProductType = (String) currentSession.getAttribute("productType");
    }
    if (oldProductType.equalsIgnoreCase(productType)) {
        currentSession.setAttribute("productType", productType);
    }

    if (productType != "") {
%>
You are searching for the product type: <strong><%=productType%></strong>
<%
    }
%>

<tr>
    <th>Item Id</th>
    <th>Item Name</th>
    <th>Price(per item)</th>
    <th>Quantity Avaliable to Purchase</th>
    <th>Product Type</th>
    <th></th>
</tr>

<%  String action = (String) request.getParameter("action");
    String productName = (String) request.getParameter("itemName");

    boolean isAdmin = false;

    // request.setAttribute("avaliableItems", shop.getAvailableItems());
    if (productType != "" && productType != null) {

        List<Product> avaliableProductsByProductName = shop.getSearchByProductName(productType);
        List<Product> avaliableProductsByProductType = shop.getSearchByProductType(productType);

        if (avaliableProductsByProductName.size() != 0) {
            for (Product item : shop.getSearchByProductName(productType)) {%>
<tr>
    <td><%=item.getId()%></td>
    <td><%=item.getName()%></td>
    <td>£<%=item.getPrice()%></td>
    <td><%=item.getQtyInStock()%></td>
    <td><%=item.getProductType()%></td>

    <td>
        <form action="./index.jsp" method="get">
            <input type="hidden" name="itemName" value=<%=item.getName()%>>
            <input type="hidden" name="action" value="addItemToCart">
            <button type="submit" onclick="" >Add Item</button> 
        </form>                    
    </td>
</tr>            
%><%
    }
} else if (avaliableProductsByProductType.size() != 0) {
    for (Product item : shop.getSearchByProductType(productType)) {%>
<tr>
    <td><%=item.getId()%></td>
    <td><%=item.getName()%></td>
    <td>£<%=item.getPrice()%></td>
    <td><%=item.getQtyInStock()%></td>
    <td><%=item.getProductType()%></td>

    <td>
        <form action="./index.jsp" method="get">
            <input type="hidden" name="itemName" value=<%=item.getName()%>>
            <input type="hidden" name="action" value="addItemToCart">
            <button type="submit" onclick="" >Add Item</button>
        </form>                    
    </td>
</tr>            
%><%
        }
    }
} else {
    for (Product item : shop.getAvailableItems()) {%>
<tr>
    <td><%=item.getId()%></td>
    <td><%=item.getName()%></td>
    <td>£<%=item.getPrice()%></td>
    <td><%=item.getQtyInStock()%></td>
    <td><%=item.getProductType()%></td>

    <td>
        <form action="./index.jsp" method="get">
            <input type="hidden" name="itemName" value=<%=item.getName()%>>
            <input type="hidden" name="action" value="addItemToCart">
            <button type="submit" onclick="" >Add Item</button>
        </form>                    
    </td>
</tr>            
<% }
    }

    if (action == null) {
        System.out.println("Nothing");
        System.out.println(action);
    } else if ("addItemToCart".equals(action)) {

        Product product = shop.getNewItemByName(productName);

        if (product != null) {
            boolean itemFound = false;
            for (Product item : shop.getShoppingCart()) {

                if (item.getName().equals(product.getName())) {
                    itemFound = true;
                    item.setCurrentQty();
                }
            }
            if (!itemFound) {
                shop.addItemToCart(product);
            }
        } else {
            System.out.println("Cannot find item");
        }
        System.out.println(action);
        System.out.println(productName);
    } else if ("purchaseCart".equals(action)) {
        if (currentUserValue == null) {
            System.out.println("User not logged in.");
            currentSession.setAttribute("shop", shop);
            response.sendRedirect("login.jsp");
        } else {
            System.out.println("You have purchased the basket. The appropriate cost of the basket has been deducted from your balance!");
            double basketCost = Double.parseDouble(shop.shoppingCartTotal());
            boolean canPurchaseBasket = shop.reduceQtyWhenPurchased();
            if (canPurchaseBasket) {
                shop.getCurrentUser().reduceBalance(basketCost);
            }
            shop.clearBasket();
            currentSession.setAttribute("shop", shop);
            response.sendRedirect("index.jsp");
        }
    }
%>

</table>
<table class="table">
    <h1><b>Items in Shopping Basket:</b> </h1>
    <tr>
        <th>Item Id</th>
        <th>Item Name</th>
        <th>Price(per item)</th>
        <th>Quantity In Basket</th>
        <th></th>
    </tr>

    <% for (Product item : shop.getShoppingCart()) {%>
    <tr>
        <td><%=item.getId()%></td>
        <td><%=item.getName()%></td>
        <td>£<%=item.getPrice()%></td>
        <td><%=item.getCurrentQty()%></td>
    </tr>  
    <% }%>
    Your current basket total: £<%=shop.shoppingCartTotal()%>
</table>
<form action="./index.jsp" method="get">
    <input type="hidden" name="action" value="purchaseCart">
    <button type="submit" onclick="" >Purchase Basket</button>                    
</form>     
