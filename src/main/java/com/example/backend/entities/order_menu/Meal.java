package com.example.backend.entities.order_menu;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@jakarta.persistence.Table(name = "meals")
public class Meal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private BigDecimal price;

    @NotBlank(message = "meal name is also mandatory")
    private String meal_name;

    @NotBlank(message = "meal description is also mandatory")
    private String meal_description;

    @ManyToOne
    @JoinColumn(name = "menu_section_id")
    private MenuSection menuSection;

    @ManyToMany(mappedBy = "meals")
    private Set<Order> orders = new HashSet<>();

    private String allergens;
}
