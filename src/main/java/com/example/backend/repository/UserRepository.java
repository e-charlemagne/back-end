package com.example.backend.repository;

import com.example.backend.actors.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.swing.text.html.Option;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User,Integer> {

    Optional<User> findByEmail(String email);
    Optional<User> findByUsername(String username);
    void deleteByUsername(String username);

}
