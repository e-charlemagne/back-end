package com.example.backend.controllers;

import com.example.backend.entities.reservation.Reservation;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.TableRepository;
import jakarta.transaction.Transactional;
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
    private final TableRepository tableRepository;

    @Autowired
    public ReservationController(ReservationRepository reservationRepository, TableRepository tableRepository) {
        this.reservationRepository = reservationRepository;
        this.tableRepository = tableRepository;
    }

    // Create a new reservation
    @PostMapping("/create")
    public ResponseEntity<Reservation> createReservation(@RequestBody Reservation reservation) {
        // Ensure the table exists
        if (tableRepository.existsById(reservation.getTable().getId())) {
            Reservation savedReservation = reservationRepository.save(reservation);
            return ResponseEntity.ok(savedReservation);
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

    // Get reservations by date
    @GetMapping("/date")
    public List<Reservation> getReservationsByDate(@RequestParam String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-M-d");
        LocalDate localDate = LocalDate.parse(date, formatter);
        return reservationRepository.findByDate(localDate);
    }

    // Get all reservations
    @GetMapping("/list")
    public List<Reservation> getAllReservations() {
        return reservationRepository.findAll();
    }

    // Get a reservation by ID
    @GetMapping("/by-id/{id}")
    public ResponseEntity<Reservation> getReservationById(@PathVariable Long id) {
        Optional<Reservation> reservation = reservationRepository.findById(id);
        return reservation.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Update a reservation by ID
    @PutMapping("/update/{id}")
    public ResponseEntity<Reservation> updateReservation(@PathVariable Long id, @RequestBody Reservation reservationDetails) {
        Optional<Reservation> optionalReservation = reservationRepository.findById(id);

        if (optionalReservation.isPresent()) {
            Reservation reservation = optionalReservation.get();
            reservation.setDate(reservationDetails.getDate());
            reservation.setTime(reservationDetails.getTime());
            reservation.setReservation_description(reservationDetails.getReservation_description());
            reservation.setReservationType(reservationDetails.getReservationType());
            reservation.setTable(reservationDetails.getTable());

            Reservation updatedReservation = reservationRepository.save(reservation);
            return ResponseEntity.ok(updatedReservation);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Delete a reservation by ID
    @Transactional
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteReservation(@PathVariable Long id) {
        if (reservationRepository.existsById(id)) {
            reservationRepository.deleteById(id);
            System.out.println("Reservation deleted: reservationRepository.existsById(id):"+
                    " :" + reservationRepository.existsById(id)+ " -> ");
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
