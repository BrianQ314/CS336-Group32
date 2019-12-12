<%-- 
    Document   : viewWaitingList
    Created on : Dec 11, 2019, 8:56:04 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Flights</title>
        <style type="text/css">
            td{padding:8px; border:1px solid black;}
        </style>
    </head>
    <body>
        <h1>View Flights</h1>
        <%
    if(session.getAttribute("user") == null){
%>        
        You are not logged in<br/>
        <a href="login.jsp">Please Login</a>
<%
    }else if(!session.getAttribute("security_level").equals("rep")){
%>        
            You do not have permission to view this page.
            <br/>
            <a href="home.jsp">Return to Home</a>
                    
<%
    }else{
        //Get the information submitted in the form
        String lineid = request.getParameter("lineid");
        String flightnum = request.getParameter("flightnum");
%>
        <a href='logout.jsp'>Log out</a> -- <a href='home.jsp'>Return To Home</a><br/>
        <div style="border: 2px solid black; padding-left:15px; margin-top:4px;">
            <p><b>View Waiting List</b></p><br/>
            <form action="viewWaitingList.jsp" method="POST">
                Flight Airline: <input type="text" name="lineid" maxlength="2"/>
                Flight Number: <input type="number" name="flightnum"/>
                <input type="submit" value="Submit"/>
            </form>
        </div>
<%
        //Make sure the JDBC driver is properly loaded
        Class.forName("com.mysql.jdbc.Driver");
        //Connect to the database
        Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
        Statement st = con.createStatement();
        ResultSet rs;

        rs = st.executeQuery("SELECT p.username, p.name FROM WaitingList w JOIN Customer c USING (username) JOIN Person p USING(username) WHERE lid='" + lineid + "' AND number = '" + flightnum + "';");
%>
        <table>
            <tr>
                <td>User</td>
                <td>Name</td>
            </tr>
            <%while(rs.next()){%>
            <tr>
                <td><%=rs.getString("username")%></td>
                <td><%=rs.getString("name")%></td>
            </tr>
            <%}%>
        </table>
<%
    }
%>
    </body>
</html>
