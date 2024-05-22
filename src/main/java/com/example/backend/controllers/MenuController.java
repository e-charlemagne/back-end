package com.example.backend.controllers;

import com.example.backend.entities.order_menu.Meal;
import com.example.backend.entities.order_menu.Menu;
import com.example.backend.entities.order_menu.MenuSection;
import com.example.backend.repository.MealRepository;
import com.example.backend.repository.MenuRepository;
import com.example.backend.repository.MenuSectionRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/menu")
public class MenuController {

    private final MenuRepository menuRepository;
    private final MealRepository mealRepository;
    private final MenuSectionRepository menuSectionRepository;

    public MenuController(MenuRepository menuRepository, MealRepository mealRepository,MenuSectionRepository menuSectionRepository) {
        this.menuRepository = menuRepository;
        this.mealRepository = mealRepository;
        this.menuSectionRepository = menuSectionRepository;
    }

    @GetMapping("/menu-list")
    public MenuAllInformation getAllData() {
        List<Meal> meals = mealRepository.findAll();
        List<MenuSection> menuSections = menuSectionRepository.findAll();
        List<Menu> menus = menuRepository.findAll();
        return new MenuAllInformation(meals, menuSections, menus);
    }
}
