package com.example.backend.repository;

import com.example.backend.entities.table.Table;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TableRepository extends JpaRepository<Table, Integer> {
    boolean existsById(Long id);

    Optional<Table> findById(Long id);

    void deleteById(Long id);
}
