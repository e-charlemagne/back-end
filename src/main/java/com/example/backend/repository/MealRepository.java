package com.example.backend.repository;

import com.example.backend.entities.order_menu.Meal;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MealRepository extends JpaRepository<Meal,Long> {
}
