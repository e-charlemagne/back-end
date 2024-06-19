package com.example.backend;

import com.example.backend.controllers.MenuController;
import com.example.backend.controllers.controller_data.MenuAllInformation;
import com.example.backend.entities.order_menu.Meal;
import com.example.backend.entities.order_menu.Menu;
import com.example.backend.entities.order_menu.MenuSection;
import com.example.backend.repository.MealRepository;
import com.example.backend.repository.MenuRepository;
import com.example.backend.repository.MenuSectionRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.ResponseEntity;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class MenuSectionMealControllerTest {

    @Mock
    private MenuRepository menuRepository;

    @Mock
    private MealRepository mealRepository;

    @Mock
    private MenuSectionRepository menuSectionRepository;

    @InjectMocks
    private MenuController menuController;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetAllMenus() {
        Menu menu1 = new Menu();
        menu1.setId(1L);
        menu1.setTitle("Menu 1");
        Menu menu2 = new Menu();
        menu2.setId(2L);
        menu2.setTitle("Menu 2");

        when(menuRepository.findAll()).thenReturn(Arrays.asList(menu1, menu2));

        List<Menu> result = menuController.getAllMenus();
        assertEquals(2, result.size());
        assertEquals("Menu 1", result.get(0).getTitle());
        assertEquals("Menu 2", result.get(1).getTitle());
    }

    @Test
    public void testGetMenuSectionsByMenuId() {
        MenuSection section1 = new MenuSection();
        section1.setId(1L);
        section1.setTitle_section("Section 1");
        MenuSection section2 = new MenuSection();
        section2.setId(2L);
        section2.setTitle_section("Section 2");

        when(menuSectionRepository.findByMenuId(1L)).thenReturn(Arrays.asList(section1, section2));

        List<MenuSection> result = menuController.getMenuSectionsByMenuId(1L);
        assertEquals(2, result.size());
        assertEquals("Section 1", result.get(0).getTitle_section());
        assertEquals("Section 2", result.get(1).getTitle_section());
    }

    @Test
    public void testGetAllData() {
        Meal meal = new Meal();
        meal.setId(1L);
        meal.setMeal_name("Meal 1");
        MenuSection menuSection = new MenuSection();
        menuSection.setId(1L);
        menuSection.setTitle_section("Section 1");
        Menu menu = new Menu();
        menu.setId(1L);
        menu.setTitle("Menu 1");

        when(mealRepository.findAll()).thenReturn(Arrays.asList(meal));
        when(menuSectionRepository.findAll()).thenReturn(Arrays.asList(menuSection));
        when(menuRepository.findAll()).thenReturn(Arrays.asList(menu));

        MenuAllInformation result = menuController.getAllData();
        assertEquals(1, result.getMeals().size());
        assertEquals("Meal 1", result.getMeals().get(0).getMeal_name());
        assertEquals(1, result.getMenuSections().size());
        assertEquals("Section 1", result.getMenuSections().get(0).getTitle_section());
        assertEquals(1, result.getMenus().size());
        assertEquals("Menu 1", result.getMenus().get(0).getTitle());
    }

    @Test
    public void testCreateMenu() {
        Menu menu = new Menu();
        menu.setId(1L);
        menu.setTitle("Menu 1");

        when(menuRepository.save(menu)).thenReturn(menu);

        Menu result = menuController.createMenu(menu);
        assertEquals("Menu 1", result.getTitle());
    }

    @Test
    public void testGetMenuById() {
        Menu menu = new Menu();
        menu.setId(1L);
        menu.setTitle("Menu 1");
        when(menuRepository.findById(1L)).thenReturn(Optional.of(menu));

        ResponseEntity<Menu> response = menuController.getMenuById(1L);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Menu 1", response.getBody().getTitle());
    }

    @Test
    public void testUpdateMenu() {
        Menu menu = new Menu();
        menu.setId(1L);
        menu.setTitle("Menu 1");
        when(menuRepository.findById(1L)).thenReturn(Optional.of(menu));

        Menu updatedMenu = new Menu();
        updatedMenu.setId(1L);
        updatedMenu.setTitle("Updated Menu");

        when(menuRepository.save(any(Menu.class))).thenReturn(updatedMenu);

        ResponseEntity<Menu> response = menuController.updateMenu(1L, updatedMenu);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Updated Menu", response.getBody().getTitle());
    }

    @Test
    public void testDeleteMenu() {
        when(menuRepository.existsById(1L)).thenReturn(true);

        ResponseEntity<Void> response = menuController.deleteMenu(1L);
        assertEquals(200, response.getStatusCodeValue());
        verify(menuRepository, times(1)).deleteById(1L);
    }

    @Test
    public void testGetAllMenuSections() {
        MenuSection section1 = new MenuSection();
        section1.setId(1L);
        section1.setTitle_section("Section 1");
        MenuSection section2 = new MenuSection();
        section2.setId(2L);
        section2.setTitle_section("Section 2");

        when(menuSectionRepository.findAll()).thenReturn(Arrays.asList(section1, section2));

        List<MenuSection> result = menuController.getAllMenuSections();
        assertEquals(2, result.size());
        assertEquals("Section 1", result.get(0).getTitle_section());
        assertEquals("Section 2", result.get(1).getTitle_section());
    }

    @Test
    public void testCreateMenuSection() {
        MenuSection section = new MenuSection();
        section.setId(1L);
        section.setTitle_section("Section 1");

        when(menuSectionRepository.save(section)).thenReturn(section);

        MenuSection result = menuController.createMenuSection(section);
        assertEquals("Section 1", result.getTitle_section());
    }

    @Test
    public void testGetMenuSectionById() {
        MenuSection section = new MenuSection();
        section.setId(1L);
        section.setTitle_section("Section 1");
        when(menuSectionRepository.findById(1L)).thenReturn(Optional.of(section));

        ResponseEntity<MenuSection> response = menuController.getMenuSectionById(1L);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Section 1", response.getBody().getTitle_section());
    }

    @Test
    public void testUpdateMenuSection() {
        MenuSection section = new MenuSection();
        section.setId(1L);
        section.setTitle_section("Section 1");
        when(menuSectionRepository.findById(1L)).thenReturn(Optional.of(section));

        MenuSection updatedSection = new MenuSection();
        updatedSection.setId(1L);
        updatedSection.setTitle_section("Updated Section");

        when(menuSectionRepository.save(any(MenuSection.class))).thenReturn(updatedSection);

        ResponseEntity<MenuSection> response = menuController.updateMenuSection(1L, updatedSection);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Updated Section", response.getBody().getTitle_section());
    }

    @Test
    public void testDeleteMenuSection() {
        when(menuSectionRepository.existsById(1L)).thenReturn(true);

        ResponseEntity<Void> response = menuController.deleteMenuSection(1L);
        assertEquals(200, response.getStatusCodeValue());
        verify(menuSectionRepository, times(1)).deleteById(1L);
    }

    @Test
    public void testGetAllMeals() {
        Meal meal1 = new Meal();
        meal1.setId(1L);
        meal1.setMeal_name("Meal 1");
        Meal meal2 = new Meal();
        meal2.setId(2L);
        meal2.setMeal_name("Meal 2");

        when(mealRepository.findAll()).thenReturn(Arrays.asList(meal1, meal2));

        List<Meal> result = menuController.getAllMeals();
        assertEquals(2, result.size());
        assertEquals("Meal 1", result.get(0).getMeal_name());
        assertEquals("Meal 2", result.get(1).getMeal_name());
    }

    @Test
    public void testCreateMeal() {
        Meal meal = new Meal();
        meal.setId(1L);
        meal.setMeal_name("Meal 1");

        when(mealRepository.save(meal)).thenReturn(meal);

        Meal result = menuController.createMeal(meal);
        assertEquals("Meal 1", result.getMeal_name());
    }

    @Test
    public void testGetMealById() {
        Meal meal = new Meal();
        meal.setId(1L);
        meal.setMeal_name("Meal 1");
        when(mealRepository.findById(1L)).thenReturn(Optional.of(meal));

        ResponseEntity<Meal> response = menuController.getMealById(1L);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Meal 1", response.getBody().getMeal_name());
    }

    @Test
    public void testUpdateMeal() {
        Meal meal = new Meal();
        meal.setId(1L);
        meal.setMeal_name("Meal 1");
        when(mealRepository.findById(1L)).thenReturn(Optional.of(meal));

        Meal updatedMeal = new Meal();
        updatedMeal.setId(1L);
        updatedMeal.setMeal_name("Updated Meal");

        when(mealRepository.save(any(Meal.class))).thenReturn(updatedMeal);

        ResponseEntity<Meal> response = menuController.updateMeal(1L, updatedMeal);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Updated Meal", response.getBody().getMeal_name());
    }

    @Test
    public void testDeleteMeal() {
        when(mealRepository.existsById(1L)).thenReturn(true);

        ResponseEntity<Void> response = menuController.deleteMeal(1L);
        assertEquals(200, response.getStatusCodeValue());
        verify(mealRepository, times(1)).deleteById(1L);
    }

    @Test
    public void testGetMealsBasedOnMenuSection() {
        Meal meal1 = new Meal();
        meal1.setId(1L);
        meal1.setMeal_name("Meal 1");
        Meal meal2 = new Meal();
        meal2.setId(2L);
        meal2.setMeal_name("Meal 2");

        when(mealRepository.findByMenuSectionId(1L)).thenReturn(Arrays.asList(meal1, meal2));

        ResponseEntity<List<Meal>> response = menuController.getMealsBasedOnMenuSection(1L);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals(2, response.getBody().size());
        assertEquals("Meal 1", response.getBody().get(0).getMeal_name());
        assertEquals("Meal 2", response.getBody().get(1).getMeal_name());
    }
}
