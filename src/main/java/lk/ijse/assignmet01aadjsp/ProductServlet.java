package lk.ijse.assignmet01aadjsp;/*
package lk.ijse.assignment1aad;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lk.ijse.assignment1aad.Product;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            // Handle product deletion
            int productId = Integer.parseInt(request.getParameter("id"));
            deleteProduct(productId);
        }

        // Fetch all products to show in the list
        List<Product> products = getAllProducts();
        request.setAttribute("products", products);

        // Forward the request to the JSP page for displaying the product list
        RequestDispatcher dispatcher = request.getRequestDispatcher("product-page.jsp");
        dispatcher.forward(request, response);
    }

    *//*

 */
/*protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("save".equals(action)) {
            // Handle saving a new product
            saveProduct(request);
        } else if ("update".equals(action)) {
            // Handle updating an existing product
            updateProduct(request);
        }

        // Redirect to the product list page after save or update
        response.sendRedirect("ProductServlet");
    }*//*
 */
/*

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle file upload
        String uploadDir = getServletContext().getRealPath("/uploads"); // Directory to store uploaded images
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdir();
        }

        // Handle form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String cid = request.getParameter("cid");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String imagePath = null;

        // Handle the image upload
        Part imagePart = request.getPart("image");
        if (imagePart != null && imagePart.getSize() > 0) {
            String imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String filePath = uploadDir + File.separator + imageFileName;
            imagePart.write(filePath);  // Save the image to the server
            imagePath = "/uploads/" + imageFileName;  // Relative path to save in the DB
        }

        // Save or update the product in the database
        String action = request.getParameter("action");
        String sql = action.equals("update") ?
                "UPDATE products SET name = ?, description = ?, price = ?, cid = ?, image_url = ?, quantity = ? WHERE id = ?" :
                "INSERT INTO products (name, description, price, cid, image_url, quantity) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, cid);
            ps.setString(5, imagePath);
            ps.setInt(6, quantity);
            if (action.equals("update")) {
                ps.setInt(7, Integer.parseInt(request.getParameter("id")));
            }

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("product-page.jsp"); // Redirect to the product management page
    }


    private List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
             PreparedStatement ps = conn.prepareStatement("SELECT p.*, c.name AS category_name FROM products p LEFT JOIN categories c ON p.cid = c.cid");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryName(rs.getString("category_name"));
                product.setImageUrl(rs.getString("image_url"));
                product.setQuantity(rs.getInt("quantity"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    private void saveProduct(HttpServletRequest request) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123")) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int cid = Integer.parseInt(request.getParameter("cid"));
            String imageUrl = request.getParameter("imageUrl");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            String sql = "INSERT INTO products (name, description, price, cid, image_url, quantity) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, description);
                ps.setDouble(3, price);
                ps.setInt(4, cid);
                ps.setString(5, imageUrl);
                ps.setInt(6, quantity);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateProduct(HttpServletRequest request) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int cid = Integer.parseInt(request.getParameter("cid"));
            String imageUrl = request.getParameter("imageUrl");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            String sql = "UPDATE products SET name = ?, description = ?, price = ?, cid = ?, image_url = ?, quantity = ? WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, description);
                ps.setDouble(3, price);
                ps.setInt(4, cid);
                ps.setString(5, imageUrl);
                ps.setInt(6, quantity);
                ps.setInt(7, id);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteProduct(int productId) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123")) {
            String sql = "DELETE FROM products WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, productId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
*//*

package lk.ijse.assignment1aad;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lk.ijse.assignment1aad.Product;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            // Handle product deletion
            int productId = Integer.parseInt(request.getParameter("id"));
            deleteProduct(productId);
        }

        // Fetch all products to show in the list
        List<Product> products = getAllProducts();
        request.setAttribute("products", products);

        // Forward the request to the JSP page for displaying the product list
        RequestDispatcher dispatcher = request.getRequestDispatcher("product-page.jsp");
        dispatcher.forward(request, response);
    }

    private void deleteProduct(int productId) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
             PreparedStatement ps = conn.prepareStatement("DELETE FROM products WHERE id = ?")) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT p.*, c.name AS category_name FROM products p " +
                             "LEFT JOIN categories c ON p.cid = c.cid");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryName(rs.getString("category_name"));
                product.setImageUrl(rs.getString("image_url"));
                product.setQuantity(rs.getInt("quantity"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("save".equals(action)) {
            saveProduct(request);
        } else if ("update".equals(action)) {
            updateProduct(request);
        }

        // After processing the request, redirect to avoid form resubmission
        response.sendRedirect("ProductServlet");
    }

    private void saveProduct(HttpServletRequest request) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int cid = Integer.parseInt(request.getParameter("cid"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part imagePart = request.getPart("image");
        String imageUrl = null;
        if (imagePart != null) {
            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            imageUrl = "uploads/" + fileName;
            imagePart.write(getServletContext().getRealPath("/") + "uploads" + File.separator + fileName);
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
             PreparedStatement ps = conn.prepareStatement("INSERT INTO products (name, description, price, cid, image_url, quantity) VALUES (?, ?, ?, ?, ?, ?)")) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setInt(4, cid);
            ps.setString(5, imageUrl);
            ps.setInt(6, quantity);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void updateProduct(HttpServletRequest request) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int cid = Integer.parseInt(request.getParameter("cid"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part imagePart = request.getPart("image");
        String imageUrl = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            imageUrl = "uploads/" + fileName;
            imagePart.write(getServletContext().getRealPath("/") + "uploads" + File.separator + fileName);
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "Ijse@123");
             PreparedStatement ps = conn.prepareStatement("UPDATE products SET name = ?, description = ?, price = ?, cid = ?, image_url = ?, quantity = ? WHERE id = ?")) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setInt(4, cid);
            ps.setString(5, imageUrl);
            ps.setInt(6, quantity);
            ps.setInt(7, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
*/

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ProductServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class ProductServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/assignment";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Ijse@123";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteProduct(request, response);
        } else if ("edit".equals(action)) {
            editProduct(request, response);
        } else {
            // handle any other GET requests, e.g., display products list
        }

        int productId = Integer.parseInt(request.getParameter("id"));

        String productName = null;
        double price = 0.0;
        String categoryName = null;
        int qtyOnHand = 0;
        String imagePath = null;

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {



            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                productName = rs.getString("product_name");
                price = rs.getDouble("price");
                categoryName = rs.getString("category_name");
                qtyOnHand = rs.getInt("qtyOnHand");

                String imageFileName = rs.getString("image_url");
                imagePath = (imageFileName != null && !imageFileName.isEmpty()) ? "/uploads/" + imageFileName : "/uploads/default.jpg";

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("productId", productId);
        request.setAttribute("productName", productName);
        request.setAttribute("price", price);
        request.setAttribute("categoryName", categoryName);
        request.setAttribute("qtyOnHand", qtyOnHand);
        request.setAttribute("imagePath", imagePath);

        RequestDispatcher dispatcher = request.getRequestDispatcher("product-page.jsp");
        dispatcher.forward(request, response);
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String editId = request.getParameter("editId");
        if (editId != null) {
            // Retrieve product details from the database and set them as request attributes
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE id = ?")) {

                Class.forName("com.mysql.cj.jdbc.Driver");
                ps.setInt(1, Integer.parseInt(editId));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("product", rs);  // You can pass the product to the JSP
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Forward to a JSP to show the product's details for editing
        request.getRequestDispatcher("product-page.jsp").forward(request, response);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("save".equals(action)) {
            saveProduct(request, response);
        } else if ("update".equals(action)) {
            updateProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        }
    }

    private void saveProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String cid = request.getParameter("cid");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part filePart = request.getPart("image_url");
        String fileName = uploadFile(filePart, request);

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO products (product_name, description, price, name, image_url, quantity) VALUES (?, ?, ?, ?, ?, ?)")) {

            Class.forName("com.mysql.cj.jdbc.Driver");

            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, cid);
            ps.setString(5, fileName);
            ps.setInt(6, quantity);
            ps.executeUpdate();

            response.sendRedirect("product-page.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String cid = request.getParameter("cid");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part filePart = request.getPart("image_url");
        String fileName = uploadFile(filePart, request);

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement ps = conn.prepareStatement(
                     "UPDATE products SET product_name = ?, description = ?, price = ?, name = ?, image_url = ?, quantity = ? WHERE id = ?")) {

            Class.forName("com.mysql.cj.jdbc.Driver");

            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, cid);
            ps.setString(5, fileName);
            ps.setInt(6, quantity);
            ps.setInt(7, id);
            ps.executeUpdate();

            response.sendRedirect("product-page.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement ps = conn.prepareStatement("DELETE FROM products WHERE id = ?")) {

            Class.forName("com.mysql.cj.jdbc.Driver");

            ps.setInt(1, id);
            ps.executeUpdate();

            response.sendRedirect("product-page.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String uploadFile(Part filePart, HttpServletRequest request) throws IOException {
        String fileName = filePart.getSubmittedFileName();

        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Store relative path for easy access in JSP
            return UPLOAD_DIR + "/" + fileName;
        }

        return "uploads/default.jpg"; // Fallback for no image
    }

}
