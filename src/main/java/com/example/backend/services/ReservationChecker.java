package com.example.backend.services;

import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.table.Table;
import com.example.backend.entities.table.TableStatus;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.TableRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

@Component
public class ReservationChecker {

    private final ReservationRepository reservationRepository;
    private final TableRepository tableRepository;

    public ReservationChecker(ReservationRepository reservationRepository, TableRepository tableRepository) {
        this.reservationRepository = reservationRepository;
        this.tableRepository = tableRepository;
    }

    @Scheduled(fixedRate = 60000) // Run every minute
    public void checkReservations() {
        try {
            LocalDateTime now = LocalDateTime.now();
            List<Reservation> reservations = reservationRepository.findByDateBetween(now.toLocalDate().atStartOfDay(), now.plusDays(1).toLocalDate().atStartOfDay());
            for (Reservation reservation : reservations) {
                if (reservation.getDate().atTime(reservation.getTime()).isBefore(now.plusMinutes(15)) &&
                        reservation.getDate().atTime(reservation.getTime()).isAfter(now)) {
                    Table table = reservation.getTables().iterator().next(); // Assuming single table per reservation for simplicity
                    if (table.getStatus().getStatus().equals("Empty_Now")) {
                        table.setStatus(new TableStatus(2L, "Reservation_Scheduled"));
                        tableRepository.save(table);
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
