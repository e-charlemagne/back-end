package com.example.backend.entities.order_menu;

import com.example.backend.entities.actors.User;
import com.example.backend.entities.table.Table;
import com.example.backend.entities.table.TableStatus;
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

    @Enumerated(EnumType.STRING)
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
            this.status = OrderStatus.New;
        }
        if (this.table != null) {
            this.table.setStatus(TableStatus.Now_Occupied);

        }

    }
}
    /**
     * Add Taxes_Discounts to the order. My suggestion would be to implement something like
     * again , EnumClass..? With, enum types of different amount of discounts.
     * I would like to implement that as ENUM and not as a functional variable due to one reason,
     * that we would be able to filter and store data more efficiently. Because, anyway,
     * that would be much harder to track orders with discounts, if that would be implemented as a function..
     * On the other hand, adding custom enum_type to DB, and create a custom field there - will help us to track this all.
     *
     * */


