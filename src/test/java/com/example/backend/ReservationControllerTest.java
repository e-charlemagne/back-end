package com.example.backend;

import com.example.backend.controllers.ReservationController;
import com.example.backend.entities.actors.User;
import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.reservation.ReservationType;
import com.example.backend.entities.table.Table;
import com.example.backend.repository.ReservationRepository;
import com.example.backend.repository.ReservationTypeRepository;
import com.example.backend.repository.TableRepository;
import com.example.backend.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.ResponseEntity;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.*;

public class ReservationControllerTest {

    @Mock
    private ReservationRepository reservationRepository;

    @Mock
    private ReservationTypeRepository reservationTypeRepository;

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
        ReservationType reservationType = new ReservationType(1L, "Birthday");
        User user = new User();
        user.setId(1);
        Table table = new Table();
        table.setId(1L);

        when(tableRepository.existsById(1L)).thenReturn(true);
        when(userRepository.existsById(1)).thenReturn(true);
        when(reservationTypeRepository.findById(1L)).thenReturn(Optional.of(reservationType));

        Reservation reservation = new Reservation();
        reservation.setDate(LocalDate.now());
        reservation.setTime(LocalTime.now());
        reservation.setReservationDescription("Birthday party");
        reservation.setCustomer(user);
        Set<Table> tables = new HashSet<>();
        tables.add(table);
        reservation.setTables(tables);
        reservation.setReservationType(reservationType);

        when(reservationRepository.save(reservation)).thenReturn(reservation);

        ResponseEntity<Reservation> response = reservationController.createReservation(reservation);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Birthday party", Objects.requireNonNull(response.getBody()).getReservationDescription());
    }

    @Test
    public void testGetReservationsByMonth() {
        Reservation reservation = new Reservation();
        reservation.setDate(LocalDate.of(2024, 6, 18));
        when(reservationRepository.findByDateBetween(any(LocalDate.class), any(LocalDate.class)))
                .thenReturn(List.of(reservation));

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
        assertEquals(1L, Objects.requireNonNull(response.getBody()).getId());
    }

    @Test
    public void testUpdateReservation() {
        Reservation reservation = new Reservation();
        reservation.setId(1L);
        reservation.setReservationDescription("original");

        when(reservationRepository.findById(1L)).thenReturn(Optional.of(reservation));

        Reservation updatedReservation = new Reservation();
        updatedReservation.setReservationDescription("updated");

        when(reservationRepository.save(any(Reservation.class))).thenReturn(updatedReservation);

        ResponseEntity<Reservation> response = reservationController.updateReservation(1L, updatedReservation);
        assertEquals(200, response.getStatusCodeValue());
        assertNotNull(response.getBody());
        assertEquals("updated", response.getBody().getReservationDescription());

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

        when(reservationRepository.findByDate(LocalDate.now())).thenReturn(List.of(reservation));

        List<Reservation> result = reservationController.getTodaysReservations();
        assertEquals(1, result.size());
        assertEquals(LocalDate.now(), result.get(0).getDate());
    }
}
