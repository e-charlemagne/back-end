package com.example.backend.controllers;


import com.example.backend.actors.User;
import com.example.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
    public List<User> getUser() {
        return _userRepository.findAll();
    }
}
