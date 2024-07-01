package com.example.backend.services;

import com.example.backend.entities.order_menu.Order;
import com.example.backend.entities.order_menu.OrderStatus;
import com.example.backend.repository.OrderRepository;
import com.example.backend.repository.TableRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private TableRepository tableRepository;

    @Transactional
    public Order createOrder(Order order) {
        OrderStatus newStatus = new OrderStatus();
        newStatus.setStatus("New");
        order.setStatus(newStatus);
        order.setOrderDate(LocalDateTime.now());
        return orderRepository.save(order);
    }
}
