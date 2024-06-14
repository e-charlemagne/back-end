package com.example.backend.controllers;

import com.example.backend.entities.actors.Role;
import com.example.backend.entities.actors.User;
import com.example.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/main")
public class UserController {

    private final UserRepository userRepository;

    @Autowired
    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/user-list")
    public List<User> getAllUsers() {
        System.out.println("Showing the list of users");
        return userRepository.findAll();
    }

    @GetMapping("/customers")
    public List<User> getUserByStatusAsCustomers() {
        return userRepository.findByRole(Role.Customer);
    }

    @PostMapping("/adding-user")
    public ResponseEntity<User> addUser(@RequestBody User user) {
        User savedUser = userRepository.save(user);
        System.out.println("User has been added");
        return ResponseEntity.ok(savedUser);
    }

    @DeleteMapping("/delete-user/{username}")
    public ResponseEntity<?> deleteUserByUserName(@PathVariable String username) {
        if (userRepository.findByUsername(username).isPresent()) {
            userRepository.deleteByUsername(username);
            System.out.println("Return 200 response if that was successfully deleted.");
            return ResponseEntity.ok().build();
        }
        System.out.println("Return 404 Not Found if the user doesn't exist");
        return ResponseEntity.notFound().build();
    }

    @PutMapping("/update-user/{username}")
    public ResponseEntity<User> updateUser(@PathVariable String username, @RequestBody User userUpdates) {
        try {
            return userRepository.findByUsername(username)
                    .map(user -> {
                        user.setFirstname(userUpdates.getFirstname());
                        user.setLastname(userUpdates.getLastname());
                        user.setPassword(userUpdates.getPassword());
                        user.setEmail(userUpdates.getEmail());
                        user.setRole(userUpdates.getRole());
                        User updatedUser = userRepository.save(user);
                        return ResponseEntity.ok(updatedUser);
                    }).orElseGet(() -> ResponseEntity.notFound().build());
        } catch (UnknownError error) {
            throw new RuntimeException("something is bad with updating...");
        }
    }
}
