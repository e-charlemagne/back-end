package com.example.backend.controllers;

import com.example.backend.entities.order_menu.Order;
import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.table.Table;
import com.example.backend.entities.table.TableStatus;
import com.example.backend.repository.OrderRepository;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.TableRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/tables")
public class TableController {

    private final TableRepository tableRepository;
    private final ReservationRepository reservationRepository;
    private final OrderRepository orderRepository;

    @Autowired
    public TableController(TableRepository tableRepository, ReservationRepository reservationRepository, OrderRepository orderRepository) {
        this.tableRepository = tableRepository;
        this.reservationRepository = reservationRepository;
        this.orderRepository = orderRepository;
    }

    @GetMapping
    public List<Table> getAllTables() {
        return tableRepository.findAll();
    }

    @GetMapping("/available")
    public List<Table> getAvailableTables() {
        return tableRepository.findByStatus(TableStatus.Empty_Now);
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
            table.setSeats_amount(tableDetails.getSeats_amount());
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
            if (table.getStatus() == TableStatus.Now_Occupied) {
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
}
