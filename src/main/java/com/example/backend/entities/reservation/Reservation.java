package com.example.backend.entities.reservation;

import com.example.backend.entities.actors.User;
import com.example.backend.entities.table.Table;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@jakarta.persistence.Table(name = "reservations")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private LocalDate date;

    @NotNull
    private LocalTime time;

    @NotBlank
    private String reservationDescription;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private User customer;

    @ManyToOne
    @JoinColumn(name = "reservation_type_id")
    @NotNull
    private ReservationType reservationType;

    @ManyToMany
    @JoinTable(
            name = "reservation_tables",
            joinColumns = @JoinColumn(name = "reservation_id"),
            inverseJoinColumns = @JoinColumn(name = "table_id")
    )
    private Set<Table> tables = new HashSet<>();

    public Table getTable() {
        return tables.iterator().next();
    }

}
