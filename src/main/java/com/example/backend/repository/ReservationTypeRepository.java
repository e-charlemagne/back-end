package com.example.backend.repository;

import com.example.backend.entities.reservation.ReservationType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationTypeRepository extends JpaRepository<ReservationType, Long> {
}
