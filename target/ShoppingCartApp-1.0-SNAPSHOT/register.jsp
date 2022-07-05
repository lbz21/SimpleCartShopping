<%-- 
    Document   : register
    Created on : 26 Mar 2022, 13:33:10
    Author     : brank
--%>

<%@page import="ooddresit.model.User"%>
<%@page import="ooddresit.model.Shop"%>
<%@page import="ooddresit.model.UserRole"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <h1>Please enter your details to create an account:</h1>
        <div style="margin: 5px">
            <div style="margin: 5px">


                <form action="" method="post">
                    <table border="0">
                        <tr><td>Username: </td><td><input type="text" name="username"style="font-size: 15px;font-weight: normal; width:100%" required></td></tr>
                        <tr><td><br></td><td><br></td></tr>
                        <tr><td>Password</td><td><input type="text" name="password"style="font-size: 15px;font-weight: normal; width:100%" required></td></tr>

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

                            if (request.getParameter("submit") != null) {
                                String usernameValue = request.getParameter("username");
                                String passwordValue = request.getParameter("password");
                             
                                User user = new User(usernameValue, passwordValue);

                                shop.addUser(user);
                                currentSession.setAttribute("shop", shop);
                                response.sendRedirect("login.jsp");

                            }


                        %>

                        <tr colspan="2" align="center"><td><input type="submit" name="submit" value="Register"></td></tr>
                    </table
                </form>
            </div>  
        </div>
        <a href="./login.jsp">Registered User Login Here</a>
    </div>
</div>
</body>
</html>
