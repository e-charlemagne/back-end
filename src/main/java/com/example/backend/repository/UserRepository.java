package com.example.backend.repository;

import com.example.backend.entities.actors.Role;
import com.example.backend.entities.actors.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User,Integer> {

    Optional<User> findByEmail(String email);
    Optional<User> findByUsername(String username);
    void deleteByUsername(String username);
    List<User> findByRole(Role role);

}
