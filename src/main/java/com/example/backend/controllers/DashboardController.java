package com.example.backend.controllers;

import com.example.backend.controllers.controller_data.DashBoardAllInformation;
import com.example.backend.entities.actors.User;
import com.example.backend.entities.order_menu.Meal;
import com.example.backend.entities.order_menu.Menu;
import com.example.backend.entities.order_menu.MenuSection;
import com.example.backend.entities.order_menu.Order;
import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.table.Table;
import com.example.backend.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/dashboard")
public class DashboardController {

    private final UserRepository userRepository;
    private final MenuRepository menuRepository;
    private final OrderRepository orderRepository;
    private final TableRepository tableRepository;
    private final ReservationRepository reservationRepository;
    private final MealRepository mealRepository;
    private final MenuSectionRepository menuSectionRepository;

    @Autowired
    public DashboardController(UserRepository userRepository,
                               MenuRepository menuRepository,
                               OrderRepository orderRepository,
                               TableRepository tableRepository,
                               ReservationRepository reservationRepository,
                               MealRepository mealRepository,
                               MenuSectionRepository menuSectionRepository) {

        this.userRepository = userRepository;
        this.menuRepository = menuRepository;
        this.orderRepository = orderRepository;
        this.tableRepository = tableRepository;
        this.reservationRepository = reservationRepository;
        this.mealRepository = mealRepository;
        this.menuSectionRepository = menuSectionRepository;
    }

    @GetMapping()
    public DashBoardAllInformation getAllInformation() {
        List<Reservation> reservations = reservationRepository.findAll();
        List<Meal> meals = mealRepository.findAll();
        List<Order> orders = orderRepository.findAll();
        List<Table> tables = tableRepository.findAll();
        List<User> users = userRepository.findAll();
        List<Menu> menus = menuRepository.findAll();
        List<MenuSection> menuSection = menuSectionRepository.findAll();

        return new DashBoardAllInformation(tables, meals, menuSection, menus, orders, reservations, users);
    }
    @GetMapping("/reservations-per-day")
    public Map<DayOfWeek, Long> getReservationsPerDay() {
        LocalDate now = LocalDate.now();
        LocalDate startOfWeek = now.with(WeekFields.of(Locale.getDefault()).dayOfWeek(), 1); // Assuming week starts on Monday
        LocalDate endOfWeek = startOfWeek.plusDays(6);

        List<Reservation> reservations = reservationRepository.findByDateBetween(startOfWeek, endOfWeek);
        return reservations.stream()
                .collect(Collectors.groupingBy(reservation -> reservation.getDate().getDayOfWeek(), Collectors.counting()));
    }

}
