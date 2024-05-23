package com.example.backend.controllers.controller_data;

import com.example.backend.entities.order_menu.Meal;
import com.example.backend.entities.order_menu.Menu;
import com.example.backend.entities.order_menu.MenuSection;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class MenuAllInformation {
    private List<Meal> meals;
    private List<MenuSection> menuSections;
    private List<Menu> menus;
}
