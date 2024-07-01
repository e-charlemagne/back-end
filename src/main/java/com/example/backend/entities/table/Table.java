package com.example.backend.entities.table;

import com.example.backend.entities.order_menu.Order;
import com.example.backend.entities.reservation.Reservation;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@jakarta.persistence.Table(name = "restaurant_tables")
public class Table {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "name is needed")
    private String name;

    private Integer seatsAmount;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "status_id", nullable = false)
    private TableStatus status;

    @OneToMany(mappedBy = "table", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<Order> orders = new HashSet<>();

    @ManyToMany(mappedBy = "tables")
    private Set<Reservation> reservations = new HashSet<>();

    public void addOrder(Order order) {
        orders.add(order);
        order.setTable(this);
    }

    public void removeOrder(Order order) {
        orders.remove(order);
        order.setTable(null);
    }

    public void addReservation(Reservation reservation) {
        reservations.add(reservation);
        reservation.getTables().add(this);
    }

    public void removeReservation(Reservation reservation) {
        reservations.remove(reservation);
        reservation.getTables().remove(this);
    }

    @PreUpdate
    public void onPreUpdate() {
        if (this.status.getStatus().equals("Now_Occupied") || this.status.getStatus().equals("Reservation_Scheduled")) {
            throw new RuntimeException("Table cannot be updated while occupied or reserved");
        }
    }
}
