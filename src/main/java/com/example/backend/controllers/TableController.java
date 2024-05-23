package com.example.backend.controllers;

import com.example.backend.entities.table.Table;
import com.example.backend.repository.OrderRepository;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.TableRepository;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/table")
public class TableController {

    private final TableRepository tableRepository;
    private final ReservationRepository resRepository;
    private final OrderRepository orderRepository;

    @Autowired
    public TableController(TableRepository tableRepository, ReservationRepository resRepository, OrderRepository orderRepository) {
        this.tableRepository = tableRepository;
        this.resRepository = resRepository;
        this.orderRepository = orderRepository;
 }
    /** http://localhost:8080/table/table-list **/
    @GetMapping("/table-list")
    public List<Table> getAllTables() {
        return tableRepository.findAll();
    }

    /** http://localhost:8080/table/create **/
    @PostMapping("/create")
    public ResponseEntity<Table> createTable(@RequestBody Table table) {
        Table savedTable = tableRepository.save(table);
        return ResponseEntity.ok(savedTable);
    }

    // Get by ID
    /** http://localhost:8080/table/1 **/
    @GetMapping("/{id}")
    public ResponseEntity<Table> getTable(@PathVariable Integer id) {
       try{
           Optional<Table> table = tableRepository.findById(id);
           return table.map(
                   ResponseEntity::ok
           ).orElseGet(() -> ResponseEntity
                   .notFound()
                   .build());
       }catch (HttpClientErrorException.NotFound e){
           throw new RuntimeException("HttpClientErrorException.NotFound");
       }

    }

    /** http://localhost:8080/table/update/1  **/
    @PutMapping("/update/{id}")
    public ResponseEntity<Table> updateTable(@PathVariable Integer id,
                                             @RequestBody Table tableDetails ) {
        try {
        Optional<Table> optionalTable = tableRepository.findById(id);
        if (optionalTable.isPresent()) {
            Table table = optionalTable.get();
            table.setName(tableDetails.getName());
            table.setSeats_amount(tableDetails.getSeats_amount());
            table.setStatus(tableDetails.getStatus());
            table.setOrders(tableDetails.getOrders());
            table.setReservations(tableDetails.getReservations());

            Table updatedTable = tableRepository.save(table);
            return ResponseEntity.ok(updatedTable);
        } else {
            return ResponseEntity.notFound().build();
        }
    } catch (UnknownError error){
            throw new RuntimeException("something is bad with updating...");
        }
    }

    /** http://localhost:8080/table/delete/1 **/
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteTable(@PathVariable Integer id) {
        if (tableRepository.existsById(id)) {
            tableRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

}
