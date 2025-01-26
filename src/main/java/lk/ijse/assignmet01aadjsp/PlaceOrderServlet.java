package lk.ijse.assignmet01aadjsp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psOrderDetails = null;
        PreparedStatement psProductUpdate = null;

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
            conn.setAutoCommit(false); // Start transaction

            // Insert the order
            String orderQuery = "INSERT INTO orders (username, total_amount) VALUES (?, ?)";
            psOrder = conn.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
            psOrder.setString(1, username);
            psOrder.setDouble(2, totalAmount);
            psOrder.executeUpdate();

            // Get the generated order ID
            ResultSet generatedKeys = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            // Insert order details
            String orderDetailQuery = "INSERT INTO order_details (order_id, product_id, quantity, total_price) VALUES (?, ?, ?, ?)";
            psOrderDetails = conn.prepareStatement(orderDetailQuery);

            // Insert for each product in the cart
            // Assume cart items are sent in the request (you can use a session or retrieve cart items from the database)
            // Example: Assuming we pass cart items (product_id, quantity) as parameters
            String[] productIds = request.getParameterValues("productIds"); // Example
            String[] quantities = request.getParameterValues("quantities"); // Example

            for (int i = 0; i < productIds.length; i++) {
                int productId = Integer.parseInt(productIds[i]);
                int quantity = Integer.parseInt(quantities[i]);

                // Get product price and calculate total price
                String productQuery = "SELECT price FROM products WHERE id = ?";
                PreparedStatement psProduct = conn.prepareStatement(productQuery);
                psProduct.setInt(1, productId);
                ResultSet productRs = psProduct.executeQuery();
                double price = 0;
                if (productRs.next()) {
                    price = productRs.getDouble("price");
                }
                double totalPrice = price * quantity;

                // Insert into order_details table
                psOrderDetails.setInt(1, orderId);
                psOrderDetails.setInt(2, productId);
                psOrderDetails.setInt(3, quantity);
                psOrderDetails.setDouble(4, totalPrice);
                psOrderDetails.addBatch();

                // Update product quantity in the products table
                String updateProductQuery = "UPDATE products SET quantity = quantity - ? WHERE id = ?";
                psProductUpdate = conn.prepareStatement(updateProductQuery);
                psProductUpdate.setInt(1, quantity);
                psProductUpdate.setInt(2, productId);
                psProductUpdate.addBatch();
            }

            // Execute all insert and update queries
            psOrderDetails.executeBatch();
            psProductUpdate.executeBatch();

            // Commit the transaction
            conn.commit();
            response.getWriter().write("Order placed successfully!");

        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.getWriter().write("Failed to place the order. Please try again.");
        } finally {
            try {
                if (psOrder != null) psOrder.close();
                if (psOrderDetails != null) psOrderDetails.close();
                if (psProductUpdate != null) psProductUpdate.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
