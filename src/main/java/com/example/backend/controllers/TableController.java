package com.example.backend.controllers;

import com.example.backend.entities.order_menu.Order;
import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.table.Table;
import com.example.backend.entities.table.TableStatus;
import com.example.backend.repository.OrderRepository;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.TableRepository;
import com.example.backend.repository.TableStatusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/tables")
public class TableController {
    private final TableRepository tableRepository;
    private final ReservationRepository reservationRepository;
    private final OrderRepository orderRepository;
    private final TableStatusRepository tableStatusRepository;

    @Autowired
    public TableController(TableRepository tableRepository, ReservationRepository reservationRepository, OrderRepository orderRepository, TableStatusRepository tableStatusRepository) {
        this.tableRepository = tableRepository;
        this.reservationRepository = reservationRepository;
        this.orderRepository = orderRepository;
        this.tableStatusRepository = tableStatusRepository;

        // Schedule task for checking reservations
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        scheduler.scheduleAtFixedRate(this::checkReservations, 0, 1, TimeUnit.MINUTES);
    }

    @GetMapping
    public List<Table> getAllTables() {
        return tableRepository.findAll();
    }

    @GetMapping("/available")
    public List<Table> getAvailableTables() {
        TableStatus emptyStatus = tableStatusRepository.findByStatus("Empty_Now").orElseThrow();
        return tableRepository.findByStatus(emptyStatus);
    }

    @PostMapping
    public ResponseEntity<Table> createTable(@RequestBody Table table) {
        Table savedTable = tableRepository.save(table);
        return ResponseEntity.ok(savedTable);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Table> getTableById(@PathVariable Long id) {
        Optional<Table> table = tableRepository.findById(id);
        return table.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Table> updateTable(@PathVariable Long id, @RequestBody Table tableDetails) {
        Optional<Table> optionalTable = tableRepository.findById(id);
        if (optionalTable.isPresent()) {
            Table table = optionalTable.get();
            table.setName(tableDetails.getName());
            table.setSeatsAmount(tableDetails.getSeatsAmount());
            table.setStatus(tableDetails.getStatus());

            table.getOrders().clear();
            for (Order order : tableDetails.getOrders()) {
                table.addOrder(order);
            }

            table.getReservations().clear();
            for (Reservation reservation : tableDetails.getReservations()) {
                table.addReservation(reservation);
            }

            try {
                Table updatedTable = tableRepository.save(table);
                return ResponseEntity.ok(updatedTable);
            } catch (Exception e) {
                System.err.println("Error updating table: " + e.getMessage());
                e.printStackTrace();
                return ResponseEntity.status(500).body(null);
            }
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @Transactional
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteTable(@PathVariable Long id) {
        Optional<Table> optionalTable = tableRepository.findById(id);
        if (optionalTable.isPresent()) {
            Table table = optionalTable.get();
            if (table.getStatus().getStatus().equals("Now_Occupied")) {
                return ResponseEntity.status(400).body("Table is currently occupied and cannot be deleted.");
            }
            tableRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/reservations/today")
    public List<Reservation> getTodaysReservations() {
        LocalDate today = LocalDate.now();
        return reservationRepository.findByDate(today);
    }

    private void checkReservations() {
        LocalDateTime now = LocalDateTime.now();
        List<Reservation> reservations = reservationRepository.findByDateBetween(now.toLocalDate().atStartOfDay(), now.plusDays(1).toLocalDate().atStartOfDay());
        for (Reservation reservation : reservations) {
            if (reservation.getDate().atTime(reservation.getTime()).isBefore(now.plusMinutes(15)) &&
                    reservation.getDate().atTime(reservation.getTime()).isAfter(now)) {
                for (Table table : reservation.getTables()) {
                    if (table.getStatus().getStatus().equals("Empty_Now")) {
                        TableStatus reservationScheduledStatus = tableStatusRepository.findByStatus("Reservation_Scheduled").orElseThrow();
                        table.setStatus(reservationScheduledStatus);
                        tableRepository.save(table);
                    }
                }
            }
        }
    }
}
