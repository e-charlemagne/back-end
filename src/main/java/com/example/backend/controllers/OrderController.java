package com.example.backend.controllers;

import com.example.backend.controllers.controller_data.OrderAllInformation;
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

import java.util.List;

@RestController
@RequestMapping("/orders")
public class OrderController {

  private final MenuRepository menuRepository;
  private final MealRepository mealRepository;
  private final MenuSectionRepository menuSectionRepository;
  private final OrderRepository orderRepository;
  private final TableRepository tableRepository;
  private final ReservationRepository reservationRepository;

    @Autowired
    public OrderController(MenuRepository menuRepository,
                           OrderRepository orderRepository,
                           MealRepository mealRepository,
                           ReservationRepository reservationRepository,
                           TableRepository tableRepository,
                           MenuSectionRepository menuSectionRepository
                           ) {
        this.menuRepository = menuRepository;
        this.mealRepository = mealRepository;
        this.menuSectionRepository = menuSectionRepository;
        this.orderRepository = orderRepository;
        this.tableRepository = tableRepository;
        this.reservationRepository = reservationRepository;

    }

    @GetMapping("/order-list")
    public OrderAllInformation getAllOrderData() {

        List<Order> orders = orderRepository.findAll();
        List<Menu> menus = menuRepository.findAll();
        List<MenuSection> menuSections = menuSectionRepository.findAll();
        List<Table> tables = tableRepository.findAll();
        List<Reservation> reservations = reservationRepository.findAll();
        List<Meal> meals = mealRepository.findAll();

        return new OrderAllInformation(tables,
                                       meals,
                                       menuSections,
                                       menus,
                                       orders,
                                       reservations);
    }



}
