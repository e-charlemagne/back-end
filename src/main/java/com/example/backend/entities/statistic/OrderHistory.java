package com.example.backend.entities.statistic;

import com.example.backend.entities.order_menu.Order;
import com.example.backend.entities.order_menu.OrderStatus;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "order_history")
public class OrderHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    private LocalDateTime timestamp;

    @Enumerated(EnumType.STRING)
    private OrderStatus status;

    private String customerName;

    private Long tableId;

    private String tableName;

    private Integer tableSeatsAmount;

    private String mealNames;

    private BigDecimal totalPrice;
}