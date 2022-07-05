<%@page import="ooddresit.model.Product"%>
<%@page import="ooddresit.model.UserRole"%>
<%@page import="ooddresit.model.User"%>
<%@page import="ooddresit.model.Shop"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Profile Page</title>

    <link rel='stylesheet' type='text/css' href='css/solentestores.css' />
    <link rel='stylesheet' type='text/css' href='css/bootstrap.min.css' />
    <link rel='stylesheet' type='text/css' href='css/navbar.css' />
</head>

<p>The web app opens on the <a href="./index.jsp">Home Page</a></p>
<h1>Welcome to your Profile</h1>
<%
    HttpSession currentSession = request.getSession();
    Shop shop;
    if (currentSession.getAttribute("shop") == null) {
        shop = new Shop();
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
<p><strong><%=currentUserValue.getUsername()%></strong>'s Profile</p>
<p><strong>Current Balance: £</strong><%=String.format("%.2f", currentUserValue.getBalance())%></p>
<%

    if (shop.getCurrentUser().getUserRole() == UserRole.ADMINISTRATOR) {
%>
<p> User: <strong><%=currentUserValue.getUsername()%></strong> is an admin</p>
<%
    currentUserIsAdmin = true;

%> 

<br>
<form action="" method="post">
    <table class="table">
        <thead>

        <tbody>
            <tr>
                <td>Product name</td>
                <td><input type="text" name="productName" value="" required/></td>
            </tr>
            <tr>
                <td>Product Type</td>
                <td><input type="text" name="productType" value="" required/></td>
            </tr>
            <tr>
                <td>Price</td>
                <td><input type="text" name="price" value="" required/></td>
            </tr>
            <tr>
                <td>Quantity in stock</td>
                <td><input type="text" name="qtyInStock" value="" required/></td>
            </tr>

        </tbody>
        </thead>
    </table>
    <button button type="submit" name ="submit">Add product now</button>
</form>

<table class="table"> 
    <h1><b>Avaliable Items to update: </b> </h1>
    <tr>
        <th>Item Id</th>
        <th>Item Name</th>
        <th>Product Type</th>
        <th>Quantity Left</th>
        <th></th>
    </tr>
    <%        for (Product item : shop.getAvailableItems()) {%>
    <tr>
        <td><%=item.getId()%></td>
        <td><%=item.getName()%></td>
        <td><%=item.getProductType()%></td>

        <td>
            <form action="./profile.jsp" method="get">
                <input type="hidden" name="itemName" value=<%=item.getName()%>>
                <input type="hidden" name="action" value="updateQuantity">
                <input type="text" id="editQuantity" name="editQuantity" value=<%=item.getQtyInStock()%>>
                <button type="submit" onclick="" >Update Product</button>                    
            </form>                    
        </td>
    </tr> 
    <% } %>
</table>
<br>
<%

        if (request.getParameter("submit") != null) {
            String productNameValue = request.getParameter("productName");
            String productTypeValue = request.getParameter("productType");
            double productPriceValue = Double.parseDouble(request.getParameter("price"));
            int productQuantityInStockValue = Integer.parseInt(request.getParameter("qtyInStock"));

            Product newProduct = new Product(productNameValue, productTypeValue, productPriceValue, productQuantityInStockValue);
            shop.addProduct(newProduct);
            currentSession.setAttribute("shop", shop);
             response.sendRedirect("profile.jsp");
        }
    }
%>




<form method="post" action="./profile.jsp">
    <input type="hidden" name="action" value="logout">
    <button type="submit" onclick="" >Logout</button>
</form>
<%
} else { %>
<p><strong>You are not logged in. Please login.</strong></p>
<p>The web app opens on the <a href="./login.jsp">Log In</a></p>
<%
    }
%>


<%
    String action = (String) request.getParameter("action");
    String val = (String) request.getParameter("editQuantity");
    String itemNameVal = request.getParameter("itemName");

    if (action == null) {
        System.out.println("Nothing");
        System.out.println(action);
    } else if ("updateQuantity".equals(action)) {
        System.out.println(val);
        Product productSearched = shop.searchByProductName(itemNameVal);

        if (productSearched != null) {
            productSearched.setQtyInStock(Integer.valueOf(val));
        } else {
            System.out.println("Could not find quantity");
        }
        currentSession.setAttribute("shop", shop);
        response.sendRedirect("profile.jsp");
    } else if ("logout".equals(action)) {
        shop.setCurrentUser(null);
        currentSession.setAttribute("shop", shop);
        response.sendRedirect("index.jsp");
    }
%>
