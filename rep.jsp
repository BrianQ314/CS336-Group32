<%-- 
    Document   : rep
    Created on : Dec 4, 2019, 3:25:28 PM
    Author     : Brian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Representative Control Panel</title>
    </head>
    <body>
        <%
            if ((session.getAttribute("user") == null)) {
        %>
            You are not logged in<br/>
            <a href="login.jsp">Please Login</a>
        <%
          } else if (!(session.getAttribute("security_level").equals("rep"))) {
        %>
            You do not have permission to view this page.
            <br/>
            <a href="home.jsp">Return to Home</a>
        <%} else {
        %>
            <h1>Customer Representative Control Panel</h1>
            Welcome <%=session.getAttribute("user")%>!
            <a href='logout.jsp'>Log out</a> -- <a href='home.jsp'>Return to Home</a>
            <div style="border: 2px solid black; padding-left:15px; margin-top:4px;">
                <p><b>Edit Aircraft, Airport, or Flight Information</b></p>
                <form action="aircraftEdit.jsp" method="POST">
                    Aircraft Number: <input type="number" name="craftid"/>
                    <input type="submit" value="Submit"/>
                </form><br/>
                <form action="airportEdit.jsp" method="POST">
                    Airport ID: <input type="text" name="portid" maxlength="3"/>
                    <input type="submit" value="Submit"/>
                </form><br/>
                <form action="flightEdit.jsp" method="POST">
                    Flight Airline: <input type="text" name="lineid" maxlength="2"/>
                    Flight Number: <input type="number" name="flightnum"/>
                    <input type="submit" value="Submit"/>
                </form><br/>
            </div>
            <div style="border: 2px solid black; padding-left:15px; margin-top:4px;">
                <p><b>View Waiting List</b></p><br/>
                <form action="viewWaitingList.jsp" method="POST">
                    Flight Airline: <input type="text" name="lineid" maxlength="2"/>
                    Flight Number: <input type="number" name="flightnum"/>
                    <input type="submit" value="Submit"/>
                </form>
            </div>
        <%
            }
        %>
    </body>
</html>
