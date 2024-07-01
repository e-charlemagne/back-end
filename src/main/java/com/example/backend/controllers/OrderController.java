package com.example.backend.controllers;

import com.example.backend.entities.order_menu.Meal;
import com.example.backend.entities.order_menu.Order;
import com.example.backend.entities.order_menu.OrderStatus;
import com.example.backend.entities.statistic.OrderHistory;
import com.example.backend.repository.OrderHistoryRepository;
import com.example.backend.repository.OrderRepository;
import com.example.backend.repository.TableRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/orders")
public class OrderController {
    private final OrderRepository orderRepository;
    private final TableRepository tableRepository;
    private final OrderHistoryRepository orderHistoryRepository;

    @Autowired
    public OrderController(OrderRepository orderRepository, TableRepository tableRepository, OrderHistoryRepository orderHistoryRepository) {
        this.orderRepository = orderRepository;
        this.tableRepository = tableRepository;
        this.orderHistoryRepository = orderHistoryRepository;
    }

    @GetMapping
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Order> getOrderById(@PathVariable Long id) {
        Optional<Order> order = orderRepository.findById(id);
        return order.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping("/post-order")
    public ResponseEntity<?> createOrder(@RequestBody Order order) {
        try {
            order.setStatus(new OrderStatus("New"));
            order.setPrice(order.calculateTotalPrice());
            Order savedOrder = orderRepository.save(order);

            // Log the order in the order_history table
            logOrderHistory(savedOrder);

            return ResponseEntity.ok(savedOrder);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("Invalid request data");
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Order> updateOrder(@PathVariable Long id, @RequestBody Order orderDetails) {
        Optional<Order> orderOptional = orderRepository.findById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            order.setCustomers(orderDetails.getCustomers());
            order.setMeals(orderDetails.getMeals());
            order.setTable(orderDetails.getTable());
            order.setStatus(orderDetails.getStatus());
            order.setOrderDate(orderDetails.getOrderDate());
            final Order updatedOrder = orderRepository.save(order);

            // Log the order update in the order_history table
            logOrderHistory(updatedOrder);

            return ResponseEntity.ok(updatedOrder);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrder(@PathVariable Long id) {
        if (orderRepository.existsById(id)) {
            orderRepository.deleteById(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    private void logOrderHistory(Order order) {
        OrderHistory orderHistory = OrderHistory.builder()
                .order(order)
                .timestamp(LocalDateTime.now())
                .customerName(order.getCustomers().stream().map(c -> c.getFirstname() + " " + c.getLastname()).reduce("", (a, b) -> a + ", " + b))
                .tableId(order.getTable().getId())
                .tableName(order.getTable().getName())
                .tableSeatsAmount(order.getTable().getSeatsAmount())
                .mealNames(order.getMeals().stream().map(Meal::getMeal_name).reduce("", (a, b) -> a + ", " + b))
                .totalPrice(order.getPrice())
                .build();
        orderHistoryRepository.save(orderHistory);
    }
}
