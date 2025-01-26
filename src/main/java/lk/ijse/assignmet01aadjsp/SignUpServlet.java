package lk.ijse.assignmet01aadjsp;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "SignUpServlet", value = "/sign-up")
public class SignUpServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String contact = req.getParameter("contact");
        String role = req.getParameter("role");

        // Hash the password using BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        String sql = "INSERT INTO Users (username, email, password, contact) VALUES (?, ?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, username);
            statement.setString(2, email);
            statement.setString(3, hashedPassword); // Correctly store the hashed password
            statement.setString(4, contact);


            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                resp.sendRedirect("sign-up.jsp?message=Registration Successfully");
            } else {
                resp.sendRedirect("sign-up.jsp?error=Registration Failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("sign-up.jsp?error=Registration Failed");
        }
    }
}
