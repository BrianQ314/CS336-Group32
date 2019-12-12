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
        String portid = request.getParameter("portid");
%>
        <a href='logout.jsp'>Log out</a> -- <a href='home.jsp'>Return To Home</a><br/>
        <div style="border:1px solid black; padding:10px;">
            <p><b>Search For Different Flight Information</b></p>
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
            rs = st.executeQuery("SELECT * FROM Flights WHERE departure_pid = '" + portid + "' OR destination_pid = '" + portid + "';");
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
            </tr>
            <%}%>
        </table>
<%
        }
%>

<%
    }
%>
    </body>
</html>
