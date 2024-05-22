package com.example.backend.repository;

import com.example.backend.entities.order_menu.MenuSection;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MenuSectionRepository extends JpaRepository<MenuSection, Long> {
}
