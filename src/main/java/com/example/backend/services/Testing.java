package com.example.backend.services;

import com.example.backend.entities.reservation.Reservation;
import com.example.backend.repository.ReservationRepository;
import org.springframework.cglib.core.Local;

import java.time.LocalDate;
import java.util.List;

public class Testing {
    public static void main(String[] args) {
        LocalDate today = LocalDate.now();
        System.out.println(today);
    }
}
