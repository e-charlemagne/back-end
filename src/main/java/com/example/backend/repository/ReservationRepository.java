package com.example.backend.repository;

import com.example.backend.entities.reservation.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface ReservationRepository extends JpaRepository<Reservation,Integer> {

    Optional<Reservation> findById(Long id);

    boolean existsById(Long id);

    void deleteById(Long id);


    List<Reservation> findByDate(LocalDate today);


    List<Reservation> findByDateBetween(LocalDate startDate, LocalDate endDate);
}
