package lk.ijse.assignmet01aadjsp;


import org.mindrot.jbcrypt.BCrypt;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private DataSource dataSource;

    public UserDAO() {
        try {
            InitialContext context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/pool");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    private static final String INSERT_USER_SQL = "INSERT INTO users (username, email, password, contact, role, status) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_USER_BY_ID = "SELECT id, username, email, password, contact, role, status FROM users WHERE id = ?";
    private static final String SELECT_ALL_USERS = "SELECT * FROM users";
    private static final String DELETE_USER_SQL = "DELETE FROM users WHERE id = ?";
    private static final String UPDATE_USER_SQL = "UPDATE users SET username = ?, email = ?, contact = ?, role = ?, status = ? WHERE id = ?";


    private String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }


    private boolean verifyPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

    public void insertUser(UserDTO user) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, hashPassword(user.getPassword()));
            preparedStatement.setString(4, user.getContact());
            preparedStatement.setString(5, user.getRole());
            preparedStatement.setString(6, user.getStatus());
            preparedStatement.executeUpdate();
        }
    }

    public UserDTO selectUser(int id) throws SQLException {
        UserDTO user = null;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                String username = rs.getString("username");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String contact = rs.getString("contact");
                String role = rs.getString("role");
                String status = rs.getString("status");
                user = new UserDTO(id, username, email, password, contact, role, status);
            }
        }
        return user;
    }

    public List<UserDTO> selectAllUsers() {
        List<UserDTO> users = new ArrayList<>();
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String username = resultSet.getString("username");
                String email = resultSet.getString("email");
                String contact = resultSet.getString("contact");
                String role = resultSet.getString("role");
                String status = resultSet.getString("status");
                UserDTO user = new UserDTO(id, username, email, contact, role, status);
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean deleteUser(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER_SQL)) {
            preparedStatement.setInt(1, id);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateUser(UserDTO user) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_SQL)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getContact());
            preparedStatement.setString(4, user.getRole());
            preparedStatement.setString(5, user.getStatus());
            preparedStatement.setInt(6, user.getId());
            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }


    public boolean validateUser(String email, String plainPassword) throws SQLException {
        String sql = "SELECT password FROM users WHERE email = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                return verifyPassword(plainPassword, hashedPassword);
            }
        }
        return false;
    }
}
