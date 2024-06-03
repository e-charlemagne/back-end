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
@jakarta.persistence.Table(name = "_table")
public class Table {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "name is needed")
    private String name;

    private Integer seats_amount;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private TableStatus status;

    @OneToMany(mappedBy = "table", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<Order> orders = new HashSet<>();

    @OneToMany(mappedBy = "table", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
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
        reservation.setTable(this);
    }

    public void removeReservation(Reservation reservation) {
        reservations.remove(reservation);
        reservation.setTable(null);
    }
    public Table(Long id) {
        this.id = id;
    }


}
