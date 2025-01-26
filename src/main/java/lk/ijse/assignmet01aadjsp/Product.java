package lk.ijse.assignmet01aadjsp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private int categoryId;
    private String categoryName;
    private String imageUrl;
    private int quantity;

    // Getters and setters...
}
