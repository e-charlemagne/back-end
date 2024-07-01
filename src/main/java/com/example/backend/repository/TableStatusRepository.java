package com.example.backend.repository;

import com.example.backend.entities.table.TableStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TableStatusRepository extends JpaRepository<TableStatus, Long> {

    Optional<TableStatus> findByStatus(String status);
}
