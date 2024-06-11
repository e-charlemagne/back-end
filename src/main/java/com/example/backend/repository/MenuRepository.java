package com.example.backend.repository;

import com.example.backend.entities.order_menu.Menu;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MenuRepository extends JpaRepository<Menu, Long> {


}
