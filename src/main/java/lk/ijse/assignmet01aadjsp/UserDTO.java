package lk.ijse.assignmet01aadjsp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserDTO {
    private int id;
    private String username;
    private String email;
    private String password;
    private String contact;
    private String role;
    private String status;

    public UserDTO(int id, String username, String email, String contact, String role, String status) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.contact = contact;
        this.role = role;
        this.status = status;
    }
}
