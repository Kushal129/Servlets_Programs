<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<%
// value get 
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email != null && password != null) {
            try {
            	 Class.forName("com.mysql.cj.jdbc.Driver");
                 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "root");
                 
                 String qry = "SELECT * FROM students WHERE email = ? AND password = ?";
                 PreparedStatement ps = con.prepareStatement(qry);
                 
                 ps.setString(1, email);
                 ps.setString(2, password);
                 
                 ResultSet resultSet = ps.executeQuery();
                 if (resultSet.next()) {
                	 // have session ma store 
                	 HttpSession ss = request.getSession();
                	 ss.setAttribute("user_name", resultSet.getString("name"));
                	 
                	 if ("admin@example.com".equals(email) && "1234".equals(password)) {
                         response.sendRedirect("admin.jsp");
                     } else {
                         response.sendRedirect("user.jsp");
                     }
                 }else{
                	 out.println("<p>Invalid email or password. Please try again.</p>");
                 }
                 
                 ps.close();
                 con.close();
                 
            	}catch(Exception e){
            		out.println("<p>Error: " + e.getMessage() + "</p>");	
            	}
            }
%>
 <form action="#" method="post">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <button type="submit">Login</button>
    </form>
</body>
</html>