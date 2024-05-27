package com.example.backend.repository;

import com.example.backend.entities.order_menu.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order,Integer> {

    Optional<Order> findById(Long id);

    boolean existsById(Long id);

    void deleteById(Long id);
}
