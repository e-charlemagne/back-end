package com.example.backend.repository;

import com.example.backend.entities.order_menu.MenuSection;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MenuSectionRepository extends JpaRepository<MenuSection, Long> {
    List<MenuSection> findByMenuId(Long menuId);
}
