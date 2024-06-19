package com.example.backend;

import com.example.backend.controllers.ReservationController;
import com.example.backend.entities.actors.User;
import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.table.Table;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.TableRepository;
import com.example.backend.repository.UserRepository;
import org.junit.jupiter.api.Assertions;
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

public class ReservationControllerTest {

    @Mock
    private ReservationRepository reservationRepository;

    @Mock
    private TableRepository tableRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private ReservationController reservationController;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testCreateReservation() {
        Table table = new Table();
        table.setId(1L);

        User customer = new User();
        customer.setId(1);

        Reservation reservation = new Reservation();
        reservation.setId(1L);
        reservation.setTable(table);
        reservation.setCustomer(customer);

        when(tableRepository.existsById(reservation.getTable().getId())).thenReturn(true);
        when(userRepository.existsById(reservation.getCustomer().getId())).thenReturn(true);
        when(reservationRepository.save(any(Reservation.class))).thenReturn(reservation);

        ResponseEntity<Reservation> response = reservationController.createReservation(reservation);
        assertEquals(200, response.getStatusCodeValue());
        assertNotNull(response.getBody());
        assertEquals(1L, response.getBody().getId());
    }

    @Test
    public void testGetReservationsByMonth() {
        Reservation reservation = new Reservation();
        reservation.setDate(LocalDate.of(2024, 6, 18));
        when(reservationRepository.findByDateBetween(any(LocalDate.class), any(LocalDate.class)))
                .thenReturn(Arrays.asList(reservation));

        List<Reservation> result = reservationController.getReservationsByMonth(2024, 6);
        assertEquals(1, result.size());
        assertEquals(LocalDate.of(2024, 6, 18), result.get(0).getDate());
    }

    @Test
    public void testGetReservationsByDate() {
        Reservation reservation = new Reservation();
        reservation.setDate(LocalDate.of(2024, 6, 18));
        when(reservationRepository.findByDate(LocalDate.of(2024, 6, 18))).thenReturn(Arrays.asList(reservation));

        List<Reservation> result = reservationController.getReservationsByDate("2024-6-18");
        assertEquals(1, result.size());
        assertEquals(LocalDate.of(2024, 6, 18), result.get(0).getDate());
    }

    @Test
    public void testGetAllReservations() {
        Reservation reservation1 = new Reservation();
        reservation1.setId(1L);
        Reservation reservation2 = new Reservation();
        reservation2.setId(2L);

        when(reservationRepository.findAll()).thenReturn(Arrays.asList(reservation1, reservation2));

        List<Reservation> result = reservationController.getAllReservations();
        assertEquals(2, result.size());
        assertEquals(1L, result.get(0).getId());
        assertEquals(2L, result.get(1).getId());
    }

    @Test
    public void testGetReservationById() {
        Reservation reservation = new Reservation();
        reservation.setId(1L);
        when(reservationRepository.findById(1L)).thenReturn(Optional.of(reservation));

        ResponseEntity<Reservation> response = reservationController.getReservationById(1L);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals(1L, response.getBody().getId());
    }

    @Test
    public void testUpdateReservation() {
        Reservation reservation = new Reservation();
        reservation.setId(1L);
        reservation.setReservation_description("original");

        when(reservationRepository.findById(1L)).thenReturn(Optional.of(reservation));

        Reservation updatedReservation = new Reservation();
        updatedReservation.setReservation_description("updated");

        when(reservationRepository.save(any(Reservation.class))).thenReturn(updatedReservation);

        ResponseEntity<Reservation> response = reservationController.updateReservation(1L, updatedReservation);
        assertEquals(200, response.getStatusCodeValue());
        assertNotNull(response.getBody());
        assertEquals("updated", response.getBody().getReservation_description());

    }

    @Test
    public void testDeleteReservation() {
        Reservation reservation = new Reservation();
        reservation.setId(1L);
        when(reservationRepository.existsById(1L)).thenReturn(true);

        ResponseEntity<Void> response = reservationController.deleteReservation(1L);
        assertEquals(204, response.getStatusCodeValue());
        verify(reservationRepository, times(1)).deleteById(1L);
    }

    @Test
    public void testGetTodaysReservations() {
        Reservation reservation = new Reservation();
        reservation.setDate(LocalDate.now());

        when(reservationRepository.findByDate(LocalDate.now())).thenReturn(Arrays.asList(reservation));

        List<Reservation> result = reservationController.getTodaysReservations();
        assertEquals(1, result.size());
        assertEquals(LocalDate.now(), result.get(0).getDate());
    }
}
