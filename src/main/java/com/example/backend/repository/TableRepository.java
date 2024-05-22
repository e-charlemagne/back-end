package com.example.backend.repository;

import com.example.backend.entities.table.Table;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TableRepository extends JpaRepository<Table, Integer> {
}
