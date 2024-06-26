package com.example.backend;

import com.example.backend.controllers.TableController;
import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.table.Table;
import com.example.backend.entities.table.TableStatus;
import com.example.backend.repository.OrderRepository;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.TableRepository;
import com.example.backend.repository.TableStatusRepository;
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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.*;

public class TableTest {

    @Mock
    private TableStatusRepository tableStatusRepository;

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
        TableStatus emptyNowStatus = new TableStatus(1L, "Empty_Now");
        Table table = new Table();
        table.setStatus(emptyNowStatus);

        when(tableStatusRepository.findByStatus("Empty_Now")).thenReturn(Optional.of(emptyNowStatus));
        when(tableRepository.findByStatus(emptyNowStatus)).thenReturn(Arrays.asList(table));

        List<Table> result = tableController.getAvailableTables();
        assertEquals(1, result.size());
        assertEquals("Empty_Now", result.get(0).getStatus().getStatus());
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
        table.setName("original");
        when(tableRepository.findById(1L)).thenReturn(Optional.of(table));

        Table updatedTable = new Table();
        updatedTable.setName("updated");

        when(tableRepository.save(any(Table.class))).thenReturn(updatedTable);

        ResponseEntity<Table> response = tableController.updateTable(1L, updatedTable);
        assertEquals(200, response.getStatusCodeValue());
        assertNotNull(response.getBody());
        assertEquals("updated", response.getBody().getName());
    }

    @Test
    public void testDeleteTable() {
        Table table = new Table();
        table.setId(1L);
        table.setStatus(new TableStatus(1L, "Empty_Now"));
        when(tableRepository.findById(1L)).thenReturn(Optional.of(table));

        ResponseEntity<String> response = tableController.deleteTable(1L);
        assertEquals(204, response.getStatusCodeValue());
        verify(tableRepository, times(1)).deleteById(1L);
    }

    @Test
    public void testGetTodaysReservations() {
        LocalDate today = LocalDate.now();
        Reservation reservation = new Reservation();
        reservation.setDate(today);

        // Logging before setting up the mock
        System.out.println("Setting up mock data for today's reservations: " + reservation);

        when(reservationRepository.findByDate(today)).thenReturn(Arrays.asList(reservation));

        List<Reservation> result = tableController.getTodaysReservations();

        // Logging the results for better understanding
        System.out.println("Today's Reservations: " + result);

        assertEquals(1, result.size());
        assertEquals(today, result.get(0).getDate());
    }
}
