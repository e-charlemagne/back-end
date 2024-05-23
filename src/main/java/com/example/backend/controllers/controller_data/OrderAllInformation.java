package com.example.backend.controllers.controller_data;

import com.example.backend.entities.order_menu.Meal;
import com.example.backend.entities.order_menu.Menu;
import com.example.backend.entities.order_menu.MenuSection;
import com.example.backend.entities.order_menu.Order;
import com.example.backend.entities.reservation.Reservation;
import com.example.backend.entities.table.Table;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class OrderAllInformation {
    private List<Table> tableList;
    private List<Meal> meals;
    private List<MenuSection> menuSections;
    private List<Menu> menus;
    private List<Order> orders;
    private List<Reservation> reservations;

}
