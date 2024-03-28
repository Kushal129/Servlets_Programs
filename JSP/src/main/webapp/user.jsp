<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback Form</title>
</head>
<body>
 <h1>Welcome, <%= session.getAttribute("user_name") %></h1>
    <h2>Submit Feedback for Teacher</h2>

    <%
        String feedback = request.getParameter("feedback");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String[] improvementAreas = request.getParameterValues("improvement_areas");
        String satisfaction = request.getParameter("satisfaction");

        if (feedback != null && rating > 0) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "root");

                int user_id = (int) session.getAttribute("user_id");
                String improvementAreasString = String.join(",", improvementAreas);

                String qry = "INSERT INTO feedback (student_id, comments, rating, improvement_areas, satisfaction) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(qry, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, user_id);
                ps.setString(2, feedback);
                ps.setInt(3, rating);
                ps.setString(4, improvementAreasString);
                ps.setString(5, satisfaction);

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<p>Feedback submitted successfully!</p>");
                } else {
                    out.println("<p>Feedback submission failed. Please try again.</p>");
                }

                ps.close();
                con.close();
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
     <form action="" method="post">
        <label for="feedback">Feedback:</label>
        <textarea id="feedback" name="feedback" rows="4" cols="50" required></textarea><br><br>

        <label for="rating">Rating (1-5):</label>
        <input type="number" id="rating" name="rating" min="1" max="5" required><br><br>

        <label>Improvement Areas:</label><br>
        <input type="checkbox" id="communication" name="improvement_areas" value="communication">
        <label for="communication">Communication</label><br>
        <input type="checkbox" id="knowledge" name="improvement_areas" value="knowledge">
        <label for="knowledge">Knowledge</label><br>
        <input type="checkbox" id="teaching_style" name="improvement_areas" value="teaching_style">
        <label for="teaching_style">Teaching Style</label><br><br>

        <label>Overall Satisfaction:</label><br>
        <input type="radio" id="satisfied" name="satisfaction" value="satisfied">
        <label for="satisfied">Satisfied</label><br>
        <input type="radio" id="neutral" name="satisfaction" value="neutral">
        <label for="neutral">Neutral</label><br>
        <input type="radio" id="unsatisfied" name="satisfaction" value="unsatisfied">
        <label for="unsatisfied">Unsatisfied</label><br><br>

        <button type="submit">Submit Feedback</button>
    </form>

</body>
</html>