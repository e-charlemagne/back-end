package com.example.backend.entities.table;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@jakarta.persistence.Table(name = "table_status")
public class TableStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String status;

    public static final TableStatus EMPTY_NOW = new TableStatus(1L, "Empty_Now");
    public static final TableStatus RESERVATION_SCHEDULED = new TableStatus(2L, "Reservation_Scheduled");

}
