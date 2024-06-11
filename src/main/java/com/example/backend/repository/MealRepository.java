package com.example.backend.repository;

import com.example.backend.entities.order_menu.Meal;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MealRepository extends JpaRepository<Meal,Long> {
    List<Meal> findByMenuSectionId(Long menuSectionId);
}
