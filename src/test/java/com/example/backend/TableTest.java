package com.example.backend;

import com.example.backend.controllers.TableController;
import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.table.Table;
import com.example.backend.entities.table.TableStatus;
import com.example.backend.repository.OrderRepository;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.TableRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.ResponseEntity;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class TableTest {

    @Mock
    private TableRepository tableRepository;

    @Mock
    private ReservationRepository reservationRepository;

    @Mock
    private OrderRepository orderRepository;

    @InjectMocks
    private TableController tableController;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetAllTables() {
        Table table1 = new Table();
        table1.setName("table1");
        Table table2 = new Table();
        table2.setName("table2");

        when(tableRepository.findAll()).thenReturn(Arrays.asList(table1, table2));

        List<Table> result = tableController.getAllTables();
        assertEquals(2, result.size());
        assertEquals("table1", result.get(0).getName());
        assertEquals("table2", result.get(1).getName());
    }

    @Test
    public void testGetAvailableTables() {
        Table table = new Table();
        table.setStatus(TableStatus.Empty_Now);

        when(tableRepository.findByStatus(TableStatus.Empty_Now)).thenReturn(Arrays.asList(table));

        List<Table> result = tableController.getAvailableTables();
        assertEquals(1, result.size());
        assertEquals(TableStatus.Empty_Now, result.get(0).getStatus());
    }

    @Test
    public void testCreateTable() {
        Table table = new Table();
        table.setName("table");

        when(tableRepository.save(table)).thenReturn(table);

        ResponseEntity<Table> response = tableController.createTable(table);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("table", response.getBody().getName());
    }

    @Test
    public void testGetTableById() {
        Table table = new Table();
        table.setId(1L);
        when(tableRepository.findById(1L)).thenReturn(Optional.of(table));

        ResponseEntity<Table> response = tableController.getTableById(1L);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals(1L, response.getBody().getId());
    }

    @Test
    public void testUpdateTable() {
        Table table = new Table();
        table.setId(1L);
        when(tableRepository.findById(1L)).thenReturn(Optional.of(table));

        Table updatedTable = new Table();
        updatedTable.setName("updated");

        ResponseEntity<Table> response = tableController.updateTable(1L, updatedTable);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("updated", response.getBody().getName());
    }

    @Test
    public void testDeleteTable() {
        Table table = new Table();
        table.setId(1L);
        table.setStatus(TableStatus.Empty_Now);
        when(tableRepository.findById(1L)).thenReturn(Optional.of(table));

        ResponseEntity<String> response = tableController.deleteTable(1L);
        assertEquals(204, response.getStatusCodeValue());
        verify(tableRepository, times(1)).deleteById(1L);
    }

    @Test
    public void testGetTodaysReservations() {
        Reservation reservation = new Reservation();
        reservation.setDate(LocalDate.now());

        when(reservationRepository.findByDate(LocalDate.now())).thenReturn(Arrays.asList(reservation));

        List<Reservation> result = tableController.getTodaysReservations();
        assertEquals(1, result.size());
        assertEquals(LocalDate.now(), result.get(0).getDate());
    }

}
