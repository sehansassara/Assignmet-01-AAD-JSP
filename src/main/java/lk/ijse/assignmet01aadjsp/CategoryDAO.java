package lk.ijse.assignmet01aadjsp;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    private DataSource dataSource;

    public CategoryDAO() {
        try {
            InitialContext context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/pool");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    private static final String INSERT_CATEGORY_SQL = "INSERT INTO categories (name, description) VALUES (?, ?)";
    private static final String SELECT_ALL_CATEGORIES_SQL = "SELECT * FROM categories";
    private static final String SELECT_CATEGORY_BY_ID_SQL = "SELECT id, name, description FROM categories WHERE id = ?";
    private static final String UPDATE_CATEGORY_SQL = "UPDATE categories SET name = ?, description = ? WHERE cid = ?";
    private static final String DELETE_CATEGORY_SQL = "DELETE FROM categories WHERE cid = ?";
    private static final String SEARCH_CATEGORIES_BY_NAME_SQL = "SELECT * FROM categories WHERE name LIKE ?";

    public void insertCategory(CategoryDTO category) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CATEGORY_SQL)) {
            preparedStatement.setString(1, category.getName());
            preparedStatement.setString(2, category.getDescription());
            preparedStatement.executeUpdate();
        }
    }

    public List<CategoryDTO> selectAllCategories() throws SQLException {
        List<CategoryDTO> categories = new ArrayList<>();
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CATEGORIES_SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("cid");
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                categories.add(new CategoryDTO(id, name, description));
            }
        }
        return categories;
    }

    public void updateCategory(CategoryDTO category) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CATEGORY_SQL)) {
            preparedStatement.setString(1, category.getName());
            preparedStatement.setString(2, category.getDescription());
            preparedStatement.setInt(3, category.getId());
            preparedStatement.executeUpdate();
        }
    }

    public void deleteCategory(int id) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CATEGORY_SQL)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        }
    }

    public List<CategoryDTO> searchCategoriesByName(String searchTerm) throws SQLException {
        List<CategoryDTO> categories = new ArrayList<>();
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_CATEGORIES_BY_NAME_SQL)) {
            preparedStatement.setString(1, "%" + searchTerm + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("cid");
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                categories.add(new CategoryDTO(id, name, description));
            }
        }
        return categories;
    }
    public CategoryDTO selectCategoryById(int id) throws SQLException {
        CategoryDTO category = null;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT cid, name, description FROM categories WHERE cid = ?")) {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                category = new CategoryDTO(id, name, description);
            }
        }
        return category;
    }

    public List<CategoryDTO> getAllCategories() throws SQLException {
        List<CategoryDTO> categories = new ArrayList<>();
        String query = "SELECT * FROM categories";  // Assuming your table is 'categories'
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                int id = resultSet.getInt("cid");
                String name = resultSet.getString("name");

                categories.add(new CategoryDTO(id, name));

            }
        }
        return categories;
    }

}
