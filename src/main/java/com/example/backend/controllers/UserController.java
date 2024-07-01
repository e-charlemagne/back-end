package com.example.backend.controllers;

import com.example.backend.entities.actors.User;
import com.example.backend.jwt.MyUserDetailsService;
import com.example.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/main")
public class UserController {

    private final MyUserDetailsService myUserDetailsService;
    private final UserRepository userRepository;

    @Autowired
    public UserController(MyUserDetailsService myUserDetailsService, UserRepository userRepository) {
        this.myUserDetailsService = myUserDetailsService;
        this.userRepository = userRepository;
    }

    @GetMapping("/user-list")
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @GetMapping("/customers")
    public List<User> getUserByStatusAsCustomers() {
        return userRepository.findByRole_RoleName("Customer");
    }

    @PostMapping("/adding-user")
    public ResponseEntity<User> addUser(@RequestBody User user) {
        User savedUser = myUserDetailsService.save(user);
        return ResponseEntity.ok(savedUser);
    }

    @DeleteMapping("/delete-user/{username}")
    public ResponseEntity<?> deleteUserByUserName(@PathVariable String username) {
        if (userRepository.findByUsername(username).isPresent()) {
            userRepository.deleteByUsername(username);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }

    @PutMapping("/update-user/{username}")
    public ResponseEntity<User> updateUser(@PathVariable String username, @RequestBody User userUpdates) {
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
    }
}
