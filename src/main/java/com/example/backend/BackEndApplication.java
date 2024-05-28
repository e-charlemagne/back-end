package com.example.backend;

import com.example.backend.entities.table.Table;
import com.example.backend.repository.TableRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BackEndApplication {
    private static TableRepository tableRepository;
    public static void main(String[] args) {
        SpringApplication.run(BackEndApplication.class, args);

    }

}
