package com.example.backend.controllers;

import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.reservation.ReservationType;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.ReservationTypeRepository;
import com.example.backend.repository.TableRepository;
import com.example.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/reservation")
public class ReservationController {

    private final ReservationRepository reservationRepository;
    private final ReservationTypeRepository reservationTypeRepository;
    private final TableRepository tableRepository;
    private final UserRepository userRepository;

    @Autowired
    public ReservationController(ReservationRepository reservationRepository, ReservationTypeRepository reservationTypeRepository, TableRepository tableRepository, UserRepository userRepository) {
        this.reservationRepository = reservationRepository;
        this.reservationTypeRepository = reservationTypeRepository;
        this.tableRepository = tableRepository;
        this.userRepository = userRepository;
    }

    @PostMapping("/create")
    public ResponseEntity<Reservation> createReservation(@RequestBody Reservation reservation) {
        if (reservation.getCustomer() == null || reservation.getCustomer().getId() == null ||
                reservation.getReservationType() == null || reservation.getReservationType().getId() == null) {
            return ResponseEntity.badRequest().body(null);
        }

        if (userRepository.existsById(reservation.getCustomer().getId())) {
            Optional<ReservationType> reservationType = reservationTypeRepository.findById(reservation.getReservationType().getId());
            if (reservationType.isPresent()) {
                reservation.setReservationType(reservationType.get());
                Reservation savedReservation = reservationRepository.save(reservation);
                return ResponseEntity.ok(savedReservation);
            } else {
                return ResponseEntity.badRequest().body(null);
            }
        } else {
            return ResponseEntity.badRequest().body(null);
        }
    }

    @GetMapping("/month")
    public List<Reservation> getReservationsByMonth(@RequestParam int year, @RequestParam int month) {
        LocalDate startDate = LocalDate.of(year, month, 1);
        LocalDate endDate = startDate.withDayOfMonth(startDate.lengthOfMonth());
        return reservationRepository.findByDateBetween(startDate, endDate);
    }

    @GetMapping("/date")
    public List<Reservation> getReservationsByDate(@RequestParam String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-M-d");
        LocalDate localDate = LocalDate.parse(date, formatter);
        return reservationRepository.findByDate(localDate);
    }

    @GetMapping("/list")
    public List<Reservation> getAllReservations() {
        return reservationRepository.findAll();
    }

    @GetMapping("/by-id/{id}")
    public ResponseEntity<Reservation> getReservationById(@PathVariable Long id) {
        Optional<Reservation> reservation = reservationRepository.findById(id);
        return reservation.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<Reservation> updateReservation(@PathVariable Long id, @RequestBody Reservation reservationDetails) {
        Optional<Reservation> optionalReservation = reservationRepository.findById(id);

        if (optionalReservation.isPresent()) {
            Reservation reservation = optionalReservation.get();
            reservation.setDate(reservationDetails.getDate());
            reservation.setTime(reservationDetails.getTime());
            reservation.setReservationDescription(reservationDetails.getReservationDescription());
            reservation.setReservationType(reservationDetails.getReservationType());
            reservation.setTables(reservationDetails.getTables());
            reservation.setCustomer(reservationDetails.getCustomer());

            Reservation updatedReservation = reservationRepository.save(reservation);
            return ResponseEntity.ok(updatedReservation);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteReservation(@PathVariable Long id) {
        if (reservationRepository.existsById(id)) {
            reservationRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/today")
    public List<Reservation> getTodaysReservations() {
        LocalDate today = LocalDate.now();
        return reservationRepository.findByDate(today);
    }
}
