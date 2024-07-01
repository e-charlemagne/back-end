package com.example.backend.repository;

import com.example.backend.entities.table.Table;
import com.example.backend.entities.table.TableStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
@Repository
public interface TableRepository extends JpaRepository<Table, Long> {

    List<Table> findByStatus(TableStatus tableStatus);


}
