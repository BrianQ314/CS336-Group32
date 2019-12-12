<%-- 
    Document   : flightListAdmin
    Created on : Dec 11, 2019, 6:31:15 PM
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
    }else if(!session.getAttribute("security_level").equals("admin")){
%>        
            You do not have permission to view this page.
            <br/>
            <a href="home.jsp">Return to Home</a>
                    
<%
    }else{
        //Get the information submitted in the form
        String type = request.getParameter("type");
        String lineid = request.getParameter("portid");
        
        //Make sure the JDBC driver is properly loaded
        Class.forName("com.mysql.jdbc.Driver");
        //Connect to the database
        Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
        Statement st = con.createStatement();
        ResultSet rs;

        if(type.equals("active")){
        rs = st.executeQuery("SELECT *, MAX(flyers) ticket_buyers FROM "
            + "(SELECT number, lid, COUNT(*) flyers FROM Trip "
            + "GROUP BY number,lid) t1 "
            + "JOIN Flights USING (number,lid);");
%>
        <table>
            <tr>
                <td>Airline</td>
                <td>Flight #</td>
                <td>Type</td>
                <td>Departure Time</td>
                <td>Arrival Time</td>
                <td>First-Class Fare</td>
                <td>Econ-Class Fare</td>
                <td>Aircraft ID</td>
                <td>Departure Airport</td>
                <td>Destination Airport</td>
                <td># of Customer</td>
            </tr>
            <%while(rs.next()){%>
            <tr>
                <td><%=rs.getString("lid")%></td>
                <td><%=rs.getString("number")%></td>
                <td><%=rs.getString("type")%></td>
                <td><%=rs.getString("depart_time")%></td>
                <td><%=rs.getString("arrive_time")%></td>
                <td><%=rs.getString("fare_first")%></td>
                <td><%=rs.getString("fare_economy")%></td>
                <td><%=rs.getString("cid")%></td>
                <td><%=rs.getString("departure_pid")%></td>
                <td><%=rs.getString("destination_pid")%></td>
                <td><%=rs.getString("ticket_buyers")%></td>
            </tr>
            <%}%>
        </table>
<%
        }else{
            
        }
%>

<%
    }
%>
    </body>
</html>
