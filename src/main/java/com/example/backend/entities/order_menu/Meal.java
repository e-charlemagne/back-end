package com.example.backend.entities.order_menu;

import jakarta.persistence.*;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "_meal")
public class Meal {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "price is mandatory")
    private int price;

    @NotBlank(message = "meal_name is also mandatory")
    private String meal_name;

    @NotBlank(message = "meal description is also mandatory")
    private String meal_description;

}
