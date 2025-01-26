package lk.ijse.assignmet01aadjsp;

import jakarta.annotation.Resource;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*

@WebServlet(name = "LoginServlet", value = "/log-in")
public class LoginServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

        @Override
        protected void doPost(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws jakarta.servlet.ServletException, IOException {
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            String sql = "SELECT * FROM users WHERE username = ?"; // Only query username as passwords are hashed

            try (Connection connection = dataSource.getConnection();
                 PreparedStatement statement = connection.prepareStatement(sql)) {

                statement.setString(1, username);


                System.out.println("Executing SQL Query: " + sql);
                System.out.println("Username: " + username);

                ResultSet rs = statement.executeQuery();

                if (rs.next()) {
                    String storedHashedPassword = rs.getString("password");
                    String role = rs.getString("role");

                    System.out.println("User found with role: " + role);

                    // Verify the password using BCrypt
                    if (BCrypt.checkpw(password, storedHashedPassword)) {
                        // Password matches
                        HttpSession session = req.getSession();
                        session.setAttribute("username", username);
                        session.setAttribute("role", role);

                        if (role.trim().equalsIgnoreCase("admin")) {
                            resp.sendRedirect("admin-dash.jsp"); // Admin redirect
                        } else if (role.trim().equalsIgnoreCase("customer")) {
                            resp.sendRedirect("order.jsp"); // Customer redirect
                        }
                    } else {
                        // Password does not match
                        System.out.println("Invalid password.");
                        req.setAttribute("error", "Invalid username or password.");
                        req.getRequestDispatcher("index.jsp").forward(req, resp);
                    }
                } else {
                    // No user found with given username
                    System.out.println("No user found with the given credentials.");
                    req.setAttribute("error", "Invalid username or password.");
                    req.getRequestDispatcher("log-in.jsp").forward(req, resp);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                throw new RuntimeException(ex);
            }
        }
    }


*/
@WebServlet(name = "LoginServlet", value = "/log-in")
public class LoginServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws jakarta.servlet.ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        String sql = "SELECT * FROM users WHERE username = ?"; // Only query username as passwords are hashed

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, username);

            System.out.println("Executing SQL Query: " + sql);
            System.out.println("Username: " + username);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");
                String role = rs.getString("role");
                int userId = rs.getInt("id"); // Assuming the column name for user ID is "user_id"

                System.out.println("User found with role: " + role);

                // Verify the password using BCrypt
                if (BCrypt.checkpw(password, storedHashedPassword)) {
                    // Password matches, set session attributes
                    HttpSession session = req.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);
                    session.setAttribute("userId", userId); // Save the user ID to session

                    if (role.trim().equalsIgnoreCase("admin")) {
                        resp.sendRedirect("admin-dash.jsp"); // Admin redirect
                    } else if (role.trim().equalsIgnoreCase("customer")) {
                        resp.sendRedirect("order.jsp"); // Customer redirect
                    }
                } else {
                    // Password does not match
                    System.out.println("Invalid password.");
                    req.setAttribute("error", "Invalid username or password.");
                    req.getRequestDispatcher("index.jsp").forward(req, resp);
                }
            } else {
                // No user found with the given username
                System.out.println("No user found with the given credentials.");
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("log-in.jsp").forward(req, resp);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }
    }
}
