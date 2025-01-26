package lk.ijse.assignmet01aadjsp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/GetCartCountServlet")
public class GetCartCountServlet extends HttpServlet {
   /* protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cartCount = 0;

        // Your logic to fetch cart count from the database or session
        // For example:
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId"); // Assuming the user is logged in and userId is stored in the session

        if (userId != null) {
            // Fetch cart count from the database for the user
            String dbUrl = "jdbc:mysql://localhost:3306/assignment";
            String dbUser = "root";
            String dbPassword = "Ijse@123";

            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                 PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM cart ")) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    cartCount = rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Send the cart count as a JSON response
        response.setContentType("application/json");
        response.getWriter().write("{\"cartCount\": " + cartCount + "}");
    }
}
*/
}