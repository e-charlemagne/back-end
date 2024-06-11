package com.example.backend.entities.reservation;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@jakarta.persistence.Table(name = "_reservation")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private LocalDate date;

    @NotNull
    private LocalTime time;

    @NotBlank
    private String reservation_description;

    /** NAME OF THE CUSTOMER WHO MADE RESERVATION*/
    /** IMPLEMENT CONFIRMATION FROM CUSTOMER SIDE
     * WHETHER RESERVATION WAS CONFIRMED.*/

    @Enumerated(EnumType.STRING)
    private ReservationType reservationType;

    @ManyToOne
    @JoinColumn(name = "table_id")
    private com.example.backend.entities.table.Table table;

    /**RESERVATION PROPOSITION*/
}
