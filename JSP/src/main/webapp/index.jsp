<%@page import="javax.lang.model.element.ModuleElement.DirectiveVisitor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Page</title>
</head>
<body>
<% 
//pela value get karvani 

String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

//have validation 

if(name != null && email != null && password != null){
	// jo badhu khali na hoi to try karvanu ke
	try{
		// 1. get Driver 
		   //Class.forName("com.mysql.jdbc.Driver");
		   Class.forName("com.mysql.cj.jdbc.Driver");

		
		// 2. Have Conductor ne bolavanu insert (ticket leva) mate 
		Connection con = DriverManager.getConnection("jdbc:mysql//localhost:3306/test" , "root" ,           "root");
		
		// 3. bus upadvi ( qry run karvi )
		
		String qry = "INSERT INTO student (name , email , password) VALUES (? , ? ,?)";
		// 4. have badha ne sit apvani potani senathi " PreparedStatement " thi.
		PreparedStatement ps = con.prepareStatement(qry);
		//set karvi 
		ps.setString(1,name );
		ps.setString(2,email );
		ps.setString(3,password );
		
		// jovanu all set rowsAffected thai ?
				
		int rowaff = ps.executeUpdate();
		
		if(rowaff > 0){
			out.println("<p>Registration successful!</p>");
			response.sendRedirect("login.jsp");
			
		}else {
            out.println("<p>Registration failed. Sorry jo sarkhu Bhul che.</p>");
        }
		 
		
		// badha avi gaya etly dor close karvano Conductor and driver bey no.
		
		ps.cancel();
		con.close();
	}catch(Exception e){
		   out.println("<p>Error: " + e.getMessage()+ "</p>");
	}
}
%>
    <h1>Student Registration</h1>
    <form action="#" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <button type="submit">Register</button>
    </form>
    
</body>
</html>