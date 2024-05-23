package com.example.backend.repository;

import com.example.backend.entities.reservation.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ReservationRepository extends JpaRepository<Reservation,Integer> {

    Optional<Reservation> findById(Long id);

    boolean existsById(Long id);

    void deleteById(Long id);
}
