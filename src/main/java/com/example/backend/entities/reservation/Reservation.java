package com.example.backend.entities.reservation;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "_reservation")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank
    private Date date;

    @NotBlank
    private String reservation_description;

    @Enumerated(EnumType.STRING)
    private ReservationType reservationType;

    @ManyToOne
    @JoinColumn(name = "table_id")
    private com.example.backend.entities.table.Table table;

}
