<%-- 
    Document   : admin
    Created on : Nov 26, 2019, 1:42:14 PM
    Author     : Brian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Control Panel</title>
    </head>
    <body>
        <%
            if ((session.getAttribute("user") == null)) {
        %>
            You are not logged in<br/>
            <a href="login.jsp">Please Login</a>
        <%
          } else if (!(session.getAttribute("security_level").equals("admin"))) {
        %>
            You do not have permission to view this page.
            <br/>
            <a href="home.jsp">Return to Home</a>
        <%} else {
        %>
            <h1>Admin Control Panel</h1>
            Welcome <%=session.getAttribute("user")%>! 
            <a href='logout.jsp'>Log out</a><br/>
            <a href='home.jsp'>Return To Home</a>
            <div style="border:1px solid black; padding:10px;">
                <p><b>Edit User Information</b></p>
                <form action="userEdit.jsp" method="POST">
                    Username: <input type="text" name="username"/> <br/>
                    <input type="submit" value="Submit"/>
                </form>
            </div><br/>
            <div style="border:1px solid black; padding:10px;">
                <p><b>Sales Information</b></p>
                <form action="sales.jsp" method="POST">
                    <input type="hidden" name="type" value="month"/>
                    <u>Monthly Sales Report</u><br/>
                    Month: <input type="month" name="reportMonth"/>
                    <input type="submit" value="Submit"/>
                </form><br/>
                <form action="sales.jsp" method="POST">
                    <input type="hidden" name="type" value="airline"/>
                    <u>Sales For Airline</u><br/>
                    Airline ID: <input type="text" name="lineid" maxlength="2"/>
                    <input type="submit" value="Submit"/>
                </form><br/>
                <form action="sales.jsp" method="POST">
                    <input type="hidden" name="type" value="flight"/>
                    <u>Sales For Flight</u><br/>
                    Flight Airline: <input type="text" name="lineid" maxlength="2"/>
                    Flight Number: <input type="number" name="flightnum"/>
                    <input type="submit" value="Submit"/>
                </form><br/>
                <form action="sales.jsp" method="POST">
                    <input type="hidden" name="type" value="cust"/>
                    <u>Sales For Customer</u><br/>
                    Customer Username: <input type="text" name="custid"/>
                    <input type="submit" value="Submit"/>
                </form><br/>
                <form action="sales.jsp" method="POST">
                    <input type="hidden" name="type" value="maxcust"/>
                    <u>Sales for the Maximum Spending Customer:</u>
                    <input type="submit" value="Go"/>
                </form>
            </div><br/>
            <div style="border:1px solid black; padding:10px;">
                <p><b>Flight Information</b></p>
                <form action="flightListAdmin.jsp" mehtod="POST">
                    <input type="hidden" name="type" value="active"/>
                    Most Active Flights: <input type="submit" value="Go"/>
                </form>
                <form action="flightListAdmin.jsp" mehtod="POST">
                    <input type="hidden" name="type" value="port"/>
                    Flights for Airport: <input type="text" name="portid" maxlength="3"/>
                    <input type="submit" value="Go"/>
                </form>
            </div>
        <%
            }
        %>
    </body>
</html>
