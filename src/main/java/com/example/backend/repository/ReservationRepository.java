package com.example.backend.repository;

import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.table.Table;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

public interface ReservationRepository extends JpaRepository<Reservation,Integer> {

    Optional<Reservation> findById(Long id);

    boolean existsById(Long id);

    void deleteById(Long id);

    List<Reservation> findByDate(LocalDate today);

    List<Reservation> findByDateBetween(LocalDateTime startDate, LocalDateTime endDate);

    List<Reservation> findByDateBetween(LocalDate startDate, LocalDate endDate);

    @Query("SELECT t FROM Table t JOIN t.reservations r WHERE r.date = :date AND r.time = :time")
    List<Table> findReservedTables(LocalDate date, LocalTime time);

}
