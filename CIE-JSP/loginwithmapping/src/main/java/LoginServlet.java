

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
       protected void doPost(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		
		if ("user1".equals(username) && "user1".equals(password)) {
            request.getSession().setAttribute("username", username);
            response.sendRedirect("WelcomeServlet");
		} else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
	}

}
