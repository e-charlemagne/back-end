package com.example.backend.entities.actors;

import com.example.backend.entities.order_menu.Order;
import jakarta.persistence.*;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;


@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "_user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @NotBlank(message = "Firstname is mandatory")
    @Size(min = 1, max = 255)
    private String firstname;

    @NotBlank(message = "Lastname is mandatory")
    @Size(min = 1, max = 255)
    private String lastname;

    @NotBlank(message = "Username is mandatory")
    @Size(min = 1, max = 255)
    private String username;

    @NotBlank(message = "Password is mandatory")
    private String password;

    @NotBlank(message = "Email is mandatory")
    @Email(message = "Email should be valid")
    private String email;

    @Enumerated(EnumType.STRING)
    private Role role;

    @ManyToMany(mappedBy = "customers")
    private List<Order> orders = new ArrayList<>();

}
