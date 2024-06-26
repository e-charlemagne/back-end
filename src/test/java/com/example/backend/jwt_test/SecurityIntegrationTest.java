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
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.transaction.TestTransaction;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
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
    @Transactional
    @Rollback
    public void setup() {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        // Ensure the user does not already exist
        Optional<User> existingUser = userRepository.findByUsername("test.user1");
        existingUser.ifPresent(userRepository::delete);
    }

    @Test
    @Transactional
    @Rollback
    public void testAuthenticationEndpoint() throws Exception {
        Roles role = new Roles();
        role.setId(3L);
        role.setRoleName("Customer");

        // Create a user and assign the role
        User user = new User();
        user.setFirstname("Test1");
        user.setLastname("User1");
        user.setUsername("test.user1");
        user.setPassword(passwordEncoder.encode("password"));
        user.setEmail("test.user1@example.com");
        user.setRole(role);

        userRepository.save(user);

        mockMvc.perform(post("/authenticate")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\": \"test.user1\", \"password\": \"password\"}"))
                .andExpect(status().isOk());
    }

    @AfterEach
    @Transactional
    @Rollback
    public void cleanup() {
        userRepository.deleteByUsername("test.user1");
    }
}
