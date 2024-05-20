package com.example.backend.controllers;


import com.example.backend.actors.User;
import com.example.backend.repository.UserRepository;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.ErrorResponse;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/main")
public class UserController {

    private final UserRepository _userRepository;

    @Autowired
    public UserController(UserRepository userRepository) {
        this._userRepository = userRepository;
    }

    @GetMapping("/user-list")
    public List<User> getAllUsers() {
        System.out.println("Showing the list of users");
        return _userRepository.findAll();
    }

    @PostMapping("/adding-user")
    public ResponseEntity<User> addUser(@RequestBody
                                            User user) {
        User savedUser = _userRepository.save(user);
        System.out.println("User has been added");
        return ResponseEntity.ok(savedUser);
    }

    @DeleteMapping("/delete-user/{username}")
    public ResponseEntity<?> deleteUserByUserName(@PathVariable String username) {
        if (_userRepository.findByUsername(username).isPresent()) {
            _userRepository.deleteByUsername(username);
            System.out.println("Return 200 response if that was successfully deleted.");
            return ResponseEntity.ok().build();

        }
        System.out.println("Return 404 Not Found if the user doesn't exist");
        return ResponseEntity.notFound().build();//
    }

    @PutMapping("/update-user/{username")
    public ResponseEntity<User> updateUser(@PathVariable String username, @RequestBody User userUpdates) {
        try {
            return _userRepository.findByUsername(username)
                    .map(user -> {
                        user.setFirstname(userUpdates.getFirstname());
                        user.setLastname(userUpdates.getLastname());
                        user.setPassword(userUpdates.getPassword());  // Assuming you want to update these fields
                        user.setEmail(userUpdates.getEmail());
                        user.setRole(userUpdates.getRole());
                        User updatedUser = _userRepository.save(user);
                        return ResponseEntity.ok(updatedUser);
                    }).orElseGet(() -> ResponseEntity.notFound().build());

        } catch (UnknownError error){
            throw new RuntimeException("something is bad with updating...");
        }
    }

}
