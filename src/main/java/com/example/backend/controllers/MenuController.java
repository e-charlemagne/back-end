package com.example.backend.controllers;

import com.example.backend.controllers.controller_data.MenuAllInformation;
import com.example.backend.entities.order_menu.Meal;
import com.example.backend.entities.order_menu.Menu;
import com.example.backend.entities.order_menu.MenuSection;
import com.example.backend.repository.MealRepository;
import com.example.backend.repository.MenuRepository;
import com.example.backend.repository.MenuSectionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/menu")
public class MenuController {

   private final MenuRepository menuRepository;
    private final MealRepository mealRepository;
    private final MenuSectionRepository menuSectionRepository;

    @Autowired
    public MenuController(MenuRepository menuRepository,
                          MealRepository mealRepository,
                          MenuSectionRepository menuSectionRepository
                        ) {
        this.menuRepository = menuRepository;
        this.mealRepository = mealRepository;
        this.menuSectionRepository = menuSectionRepository;
    }

    /** http://localhost:8080/menu/menu-list **/
    @GetMapping("/menu-list")
    public List<Menu> getAllMenus(){
        return menuRepository.findAll();
    }

    /** http://localhost:8080/menu/{menuId}/sections **/
    @GetMapping("/{menuId}/sections")
    public List<MenuSection> getMenuSectionsByMenuId(@PathVariable Long menuId) {
        return menuSectionRepository.findByMenuId(menuId);
    }


    /** http://localhost:8080/menu/menu-all-list */
    @GetMapping("/menu-all-list")
    public MenuAllInformation getAllData() {
        List<Meal> meals = mealRepository.findAll();
        List<MenuSection> menuSections = menuSectionRepository.findAll();
        List<Menu> menus = menuRepository.findAll();
        return new MenuAllInformation(meals, menuSections, menus);
    }


    // CRUD operations for Menu
    /** http://localhost:8080/menu/create-menu */
    @PostMapping("/create-menu")
    public Menu createMenu(@RequestBody Menu menu) {
        return menuRepository.save(menu);
    }

    /** http://localhost:8080/menu/menu-id/5 */
    @GetMapping("/menu-id/{id}")
    public ResponseEntity<Menu> getMenuById(@PathVariable Long id) {
        Optional<Menu> menu = menuRepository.findById(id);
        return menu.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    /** http://localhost:8080/menu/menu-update/5 */
    @PutMapping("/menu-update/{id}")
    public ResponseEntity<Menu> updateMenu(@PathVariable Long id, @RequestBody Menu menuDetails) {
        Optional<Menu> menuOptional = menuRepository.findById(id);
        if (menuOptional.isPresent()) {
            Menu menu = menuOptional.get();
            menu.setTitle(menuDetails.getTitle());
            final Menu updatedMenu = menuRepository.save(menu);
            return ResponseEntity.ok(updatedMenu);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /** http://localhost:8080/menu/menu-delete/5 */
    @DeleteMapping("/menu-delete/{id}")
    public ResponseEntity<Void> deleteMenu(@PathVariable Long id) {
        if (menuRepository.existsById(id)) {
            menuRepository.deleteById(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /** CRUD operations for MenuSection **/
    /** http://localhost:8080/menu/menusection-all */

    @GetMapping("menusection-all")
    public List<MenuSection> getAllMenuSections() {
        return menuSectionRepository.findAll();
    }

    /** http://localhost:8080/menu/create-menusection */

    @PostMapping("/create-menusection")
    public MenuSection createMenuSection(@RequestBody MenuSection menuSection) {
        return menuSectionRepository.save(menuSection);
    }

    /** http://localhost:8080/menu/menusection/1 */
    @GetMapping("/menusection/{id}")
    public ResponseEntity<MenuSection> getMenuSectionById(@PathVariable Long id) {
        Optional<MenuSection> menuSection = menuSectionRepository.findById(id);
        return menuSection.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }
    /** http://localhost:8080/menu/menusection-update/4 */
    @PutMapping("/menusection-update/{id}")
    public ResponseEntity<MenuSection> updateMenuSection(@PathVariable Long id, @RequestBody MenuSection menuSectionDetails) {
        Optional<MenuSection> menuSectionOptional = menuSectionRepository.findById(id);
        if (menuSectionOptional.isPresent()) {
            MenuSection menuSection = menuSectionOptional.get();
            menuSection.setTitle_section(menuSectionDetails.getTitle_section());
            menuSection.setMenu(menuSectionDetails.getMenu());
            final MenuSection updatedMenuSection = menuSectionRepository.save(menuSection);
            return ResponseEntity.ok(updatedMenuSection);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /** http://localhost:8080/menu/menusection-delete/4 */
    @DeleteMapping("/menusection-delete/{id}")
    public ResponseEntity<Void> deleteMenuSection(@PathVariable Long id) {
        if (menuSectionRepository.existsById(id)) {
            menuSectionRepository.deleteById(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // CRUD operations for Meal

    /** http://localhost:8080/menu/meal-list */
    @GetMapping("/meal-list")
    public List<Meal> getAllMeals() {
        return mealRepository.findAll();
    }

    /** http://localhost:8080/menu/meal-add */
    @PostMapping("/meal-add")
    public Meal createMeal(@RequestBody Meal meal) {
        return mealRepository.save(meal);
    }

    /** http://localhost:8080/menu/meal/1 */
    @GetMapping("/meal/{id}")
    public ResponseEntity<Meal> getMealById(@PathVariable Long id) {
        Optional<Meal> meal = mealRepository.findById(id);
        return meal.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PutMapping("/meal-update/{id}")
    public ResponseEntity<Meal> updateMeal(@PathVariable Long id, @RequestBody Meal mealDetails) {
        Optional<Meal> mealOptional = mealRepository.findById(id);
        if (mealOptional.isPresent()) {
            Meal meal = mealOptional.get();
            meal.setPrice(mealDetails.getPrice());
            meal.setMeal_name(mealDetails.getMeal_name());
            meal.setMeal_description(mealDetails.getMeal_description());
            meal.setMenuSection(mealDetails.getMenuSection());
            final Meal updatedMeal = mealRepository.save(meal);
            return ResponseEntity.ok(updatedMeal);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/meal-delete/{id}")
    public ResponseEntity<Void> deleteMeal(@PathVariable Long id) {
        if (mealRepository.existsById(id)) {
            mealRepository.deleteById(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }


}
