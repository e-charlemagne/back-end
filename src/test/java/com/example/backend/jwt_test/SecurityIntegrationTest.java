package com.example.backend.jwt_test;

import com.example.backend.entities.actors.Roles;
import com.example.backend.entities.actors.User;
import com.example.backend.repository.UserRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.Optional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
public class SecurityIntegrationTest {

    @Autowired
    private WebApplicationContext webApplicationContext;

    private MockMvc mockMvc;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @BeforeEach
    public void setup() {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }
    @AfterEach
    public void cleanup() {
        userRepository.deleteByUsername("test.user");
    }
    @Test
    public void testAuthenticationEndpoint() throws Exception {
        // Ensure the user does not already exist
        Optional<User> existingUser = userRepository.findByUsername("test.user");
        existingUser.ifPresent(userRepository::delete);

        Roles role = new Roles();
        role.setId(3L);
        role.setRoleName("Customer");

        // Create a user and assign the role
        User user = new User();
        user.setFirstname("Test");
        user.setLastname("User");
        user.setUsername("test.user");
        user.setPassword(passwordEncoder.encode("password"));
        user.setEmail("test.user@example.com");
        user.setRole(role);

        userRepository.save(user);

        mockMvc.perform(post("/authenticate")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\": \"test.user\", \"password\": \"password\"}"))
                .andExpect(status().isOk());
    }
}
