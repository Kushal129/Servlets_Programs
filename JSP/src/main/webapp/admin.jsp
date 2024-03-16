<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Feedback</title>
</head>
<body>
 <h1>Welcome, <%= session.getAttribute("user_name") %></h1>
 
  <h2>Manage Feedback</h2>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Student ID</th>
                <th>Comments</th>
                <th>Rating</th>
                <th>Improvement Areas</th>
                <th>Satisfaction</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
         <%
                String deleteId = request.getParameter("deleteId");
                if (deleteId != null && !deleteId.isEmpty()) {
                    try {
                        int id = Integer.parseInt(deleteId);
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "root");

                        String deleteQry = "DELETE FROM feedback WHERE id = ?";
                        PreparedStatement deletePs = con.prepareStatement(deleteQry);
                        deletePs.setInt(1, id);

                        int rowsAffected = deletePs.executeUpdate();
                        if (rowsAffected > 0) {
                            out.println("<p>Feedback deleted successfully!</p>");
                        } else {
                            out.println("<p>Feedback deletion failed. Please try again.</p>");
                        }

                        deletePs.close();
                        con.close();
                    } catch (ClassNotFoundException | SQLException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                }

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "root");

                    String qry = "SELECT * FROM feedback";
                    PreparedStatement ps = con.prepareStatement(qry);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        int student_id = rs.getInt("student_id");
                        String comments = rs.getString("comments");
                        int rating = rs.getInt("rating");
                        String improvement_areas = rs.getString("improvement_areas");
                        String satisfaction = rs.getString("satisfaction");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= student_id %></td>
                <td><%= comments %></td>
                <td><%= rating %></td>
                <td><%= improvement_areas %></td>
                <td><%= satisfaction %></td>
                <td><a href="edit.jsp?id=<%= id %>">Edit</a></td>
                <td>
                    <form action="#" method="post">
                        <input type="hidden" name="deleteId" value="<%= id %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            %>
        </tbody>
    </table>
    
    <form action="logout.jsp" method="post">
    <button type="submit">Logout</button>
</form>
</body>
</html>