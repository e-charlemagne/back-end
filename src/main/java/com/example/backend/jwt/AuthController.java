package com.example.backend.jwt;

import com.example.backend.entities.actors.Roles;
import com.example.backend.entities.actors.User;
import com.example.backend.repository.RolesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private MyUserDetailsService userDetailsService;

    @Autowired
    private RolesRepository rolesRepository;

    @PostMapping("/authenticate")
    public String createAuthenticationToken(@RequestBody AuthenticationRequest authenticationRequest) throws Exception {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            authenticationRequest.getUsername(), authenticationRequest.getPassword())
            );
        } catch (BadCredentialsException e) {
            throw new Exception("Incorrect username or password", e);
        }

        final UserDetails userDetails = userDetailsService
                .loadUserByUsername(authenticationRequest.getUsername());

        String token = jwtUtil.generateToken(userDetails);
        System.out.println("Generated JWT: " + token);

        return token;
    }

    @PostMapping("/register")
    public String registerUser(@RequestBody User user) {
        Roles customerRole = rolesRepository
                .findByRoleName("Customer")
                .orElseThrow(() -> new IllegalStateException("Role not found"));
        user.setRole(customerRole);
        userDetailsService.save(user);
        return "User registered successfully";
    }
}
