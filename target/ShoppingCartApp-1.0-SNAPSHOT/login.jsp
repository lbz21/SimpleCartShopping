<%-- 
    Document   : login
    Created on : 23 Mar 2022, 15:51:12
    Author     : brank
--%>

<%@page import="ooddresit.model.User"%>
<%@page import="ooddresit.model.Shop"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart Login</title>
    </head>
    <body>
        <h1>Hello World!</h1>


        <main role="main" class="container">
            <H1>Login</H1>
            <div style="color:red;">${errorMessage}</div>
            <div style="color:green;">${message}</div>

            <form action="" method="post">
                <input type="hidden" name="action" value="login">
                <p>Username <input type="text" name="username" ></input></p><BR>
                <p>Password <input type="password" name="password" ></input></p>
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

                        if (shop.getCurrentUser() == null) {
                    %>
                <p>Please login before attempting to purchase items in your basket.</p>

                <%
                    }

                    if (request.getParameter("submit") != null) {
                        String usernameValue = request.getParameter("username");
                        String passwordValue = request.getParameter("password");

                        User username = null;

                        username = shop.userExists(usernameValue, passwordValue);

                        if (username != null) {
                            shop.setCurrentUser(username);
                            System.out.println("Successful login");
                            currentSession.setAttribute("shop", shop);
                            response.sendRedirect("index.jsp");

                        } else {
                            System.out.println("Unsuccessful login");
                            String message = "Unsuccessful login. Please try again!";
                            out.println(message);
                        }
                    }
                %>
                <p><button type="submit" name ="submit" >Log In</button></p>
            </form>
            <a href="./register.jsp">Create a new account</a>
        </main>




    </body>
</html>
