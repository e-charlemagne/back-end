package com.example.backend.entities.order_menu;

import com.example.backend.entities.actors.User;
import com.example.backend.entities.table.Table;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@jakarta.persistence.Table(name = "orders")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime orderDate;

    @ManyToMany
    @JoinTable(
            name = "order_meals",
            joinColumns = @JoinColumn(name = "order_id"),
            inverseJoinColumns = @JoinColumn(name = "meal_id")
    )
    private Set<Meal> meals = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "table_id")
    private Table table;

    @ManyToOne
    @JoinColumn(name = "status_id", nullable = false)
    private OrderStatus status;

    @ManyToMany
    @JoinTable(
            name = "order_customers",
            joinColumns = @JoinColumn(name = "order_id"),
            inverseJoinColumns = @JoinColumn(name = "customer_id")
    )
    private List<User> customers = new ArrayList<>();

    private BigDecimal price;

    public BigDecimal calculateTotalPrice() {
        return meals.stream()
                .map(meal -> meal.getPrice() != null ? meal.getPrice() : BigDecimal.ZERO)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @PrePersist
    public void onPrePersist() {
        if (this.status == null) {
            this.status = new OrderStatus();
            this.status.setStatus("New");
        }
        if (this.table != null) {
            this.table.getStatus().setStatus("Now_Occupied");
        }
    }
}
