<%-- 
    Document   : modifyFlightInfo
    Created on : Dec 6, 2019, 4:11:37 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    //Get the all of the required fields from the form submission
    String actionType = request.getParameter("action");   
    String flightnum = request.getParameter("flightnum");   
    String lineid = request.getParameter("lineid");
    String ftype = request.getParameter("ftype");
    String depart_time = request.getParameter("depart_time");
    String arrive_time = request.getParameter("arrive_time");
    String fare_economy = request.getParameter("fare_economy");
    String fare_first = request.getParameter("fare_first");
    String craftid = request.getParameter("craftid");
    String depart_port = request.getParameter("depart_port");
    String dest_port = request.getParameter("dest_port");
    String[] day_num = request.getParameterValues("day_num");
    //Make sure the JDBC driver is properly loaded
    Class.forName("com.mysql.jdbc.Driver");
    //Connect to the database
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
    Statement st = con.createStatement();
    ResultSet rs;
    if(actionType.equals("update")){
        //Make sure that this flight exists
        rs = st.executeQuery("SELECT * FROM Flights WHERE number='" + flightnum + "' AND lid='" + lineid + "';");
        if(rs.next()){
            //Make sure that the aircraft exists
            rs = st.executeQuery("SELECT * FROM Aircraft WHERE cid='" + craftid + "';");
            if(rs.next()){
                //Make sure that the airports exist
                rs = st.executeQuery("SELECT * FROM Airports WHERE pid='" + depart_port + "' OR pid='" + dest_port + "';");
                if(rs.next() && rs.next()){
                    st.executeUpdate("UPDATE Flights SET " 
                    + "type='" + ftype + "', " 
                    + "depart_time='" + depart_time + "', " 
                    + "arrive_time='" + arrive_time + "', " 
                    + "fare_first='" + fare_first + "', " 
                    + "fare_economy='" + fare_economy + "', " 
                    + "cid='" + craftid + "', " 
                    + "departure_pid='" + depart_port + "', " 
                    + "destination_pid='" + dest_port + "' "
                    + "WHERE number='" + flightnum + "' AND lid='" + lineid + "';");
                    response.sendRedirect("flightEdit.jsp?flightnum="+flightnum+"&lineid="+lineid+"&success=true");

                    //Add all the days which this flight flies on to the flies_on relationship
                    if(day_num != null && day_num.length > 0){
                        //Delete all instances of flies_on for this flight for simplicity
                        st.executeUpdate("DELETE FROM flies_on WHERE number='" + flightnum + "' AND lid='" + lineid + "';");
                        String flies_on_update = "INSERT INTO flies_on VALUES ";
                        int day_index;
                        for(int i = 0; i < day_num.length; i++){
                            day_index = Integer.parseInt(day_num[i]);
                            flies_on_update += "( " + flightnum + ", '" + lineid + "', " + day_index + ")";
                            if(i+1 < day_num.length)
                                flies_on_update += ", ";
                        }
                        flies_on_update += ";";
                        System.out.println("Days insert text: "+flies_on_update);
                        st.executeUpdate(flies_on_update);
                    }
                }else{
                    out.println("Error: One or both of the airports entered do not exist!");
                    out.println("<a href='home.jsp'>Return to Home</a>");
                } 
            }else{
                out.println("Error: Aircraft ID " + craftid + " does not exist!");
                out.println("<a href='home.jsp'>Return to Home</a>");
            }
        }else{
            out.println("Error: Flight " + flightnum + " for " + lineid + " Airline does not exist!");
            out.println("<a href='home.jsp'>Return to Home</a>");
        }
    } else if(actionType.equals("create")){
        rs = st.executeQuery("SELECT * FROM Flights WHERE number='" + flightnum + "' AND lid='" + lineid + "';");
        if(rs.next()){
            out.println("Error: Flight " + flightnum + " for " + lineid + " Airline already exists!");
            out.println("<a href='home.jsp'>Return to Home</a>");
        }else{
            //Make sure that the airline exists
            rs = st.executeQuery("SELECT * FROM Airlines WHERE lid='" + lineid + "';");
            if(rs.next()){
                //Make sure that the aircraft exists
                rs = st.executeQuery("SELECT * FROM Aircraft WHERE cid='" + craftid + "';");
                if(rs.next()){
                    //Make sure that the airports exist
                    rs = st.executeQuery("SELECT * FROM Airports WHERE pid='" + depart_port + "' OR pid='" + dest_port + "';");
                    if(rs.next() && rs.next()){
                        st.executeUpdate("INSERT INTO Flights VALUES ('"
                                + flightnum + "', '" 
                                + lineid + "', '" 
                                + ftype + "', '" 
                                + depart_time + "', '" 
                                + arrive_time + "', '" 
                                + fare_first + "', '" 
                                + fare_economy + "', '" 
                                + craftid + "', '" 
                                + depart_port + "', '" 
                                + dest_port + "');");
                        //Add all the days which this flight flies on to the flies_on relationship
                        if(day_num != null && day_num.length > 0){
                            String flies_on_update = "INSERT INTO flies_on VALUES ";
                            int day_index;
                            for(int i = 0; i < day_num.length; i++){
                                day_index = Integer.parseInt(day_num[i]);
                                flies_on_update += "( " + flightnum + ", '" + lineid + "', " + day_index + ")";
                                if(i+1 < day_num.length)
                                    flies_on_update += ", ";
                            }
                            flies_on_update += ";";
                            System.out.println("Days insert text: "+flies_on_update);
                            st.executeUpdate(flies_on_update);
                        }
                        response.sendRedirect("flightEdit.jsp?flightnum="+flightnum+"&lineid="+lineid+"&success=true");
                    }else{
                        out.println("Error: One or both of the airports entered do not exist!");
                        out.println("<a href='home.jsp'>Return to Home</a>");
                    } 
                }else{
                    out.println("Error: Aircraft ID " + craftid + " does not exist!");
                    out.println("<a href='home.jsp'>Return to Home</a>");
                }
            }else{
                out.println("Error: Airline " + lineid + " does not exist!");
                out.println("<a href='home.jsp'>Return to Home</a>");
            }
        }
    } else if(actionType.equals("delete")){
        st.executeUpdate("DELETE FROM Flights WHERE number='" + flightnum + "' AND lid='" + lineid + "';");
        st.executeUpdate("DELETE FROM flies_on WHERE number='" + flightnum + "' AND lid='" + lineid + "';");
        response.sendRedirect("flightEdit.jsp?flightnum="+flightnum+"&lineid="+lineid+"&success=true");
    }
    
    
%>
