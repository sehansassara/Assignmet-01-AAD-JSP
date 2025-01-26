package lk.ijse.assignmet01aadjsp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123")) {
            String query = "INSERT INTO cart (product_id, quantity) VALUES (?, 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setInt(1, productId);
                int rows = ps.executeUpdate();
                if (rows > 0) {
                    out.write("{\"success\": true}");
                } else {
                    out.write("{\"success\": false, \"message\": \"Failed to update cart.\"}");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}
