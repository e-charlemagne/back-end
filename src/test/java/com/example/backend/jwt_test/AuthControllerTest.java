package com.example.backend.jwt_test;

import com.example.backend.entities.actors.Roles;
import com.example.backend.entities.actors.User;
import com.example.backend.jwt.*;
import com.example.backend.repository.UserRepository;
import com.example.backend.repository.RolesRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;

import java.util.ArrayList;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(AuthController.class)
@Import({SecurityConfigurer.class, JwtUtil.class, JwtRequestFilter.class})
public class AuthControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserRepository userRepository;

    @MockBean
    private RolesRepository rolesRepository;

    @MockBean
    private MyUserDetailsService myUserDetailsService;

    @MockBean
    private JwtUtil jwtUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @MockBean
    private AuthenticationManager authenticationManager;


    private User user;

    @BeforeEach
    public void setup() {
        Roles role = new Roles();
        role.setId(1L); // Assuming role with ID 1 exists in your DB
        role.setRoleName("Customer");

        user = new User();
        user.setId(1);
        user.setFirstname("Yevhenii1");
        user.setLastname("Siryi1");
        user.setUsername("yevhenii.siryi");
        user.setPassword(passwordEncoder.encode("admin"));
        user.setEmail("yevhenii.siryi@example.com");
        user.setRole(role);

        when(rolesRepository.findByRoleName("Customer")).thenReturn(Optional.of(role));
    }

    @Test
    public void testCreateAuthenticationToken() throws Exception {
        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class)))
                .thenReturn(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword(), new ArrayList<>()));

        when(myUserDetailsService.loadUserByUsername(any())).thenReturn(
                new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), new ArrayList<>())
        );

        when(jwtUtil.generateToken(any())).thenReturn("mocked-token");

        mockMvc.perform(post("/authenticate")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\": \"test.user\", \"password\": \"password\"}"))
                .andExpect(status().isOk());
    }


    @Test
    public void testRegisterUser() throws Exception {
        when(userRepository.save(any(User.class))).thenAnswer(invocation -> {
            User user = invocation.getArgument(0);
            return user;
        });

        mockMvc.perform(post("/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"firstname\": \"Yevhenii\", \"lastname\": \"Siryi\", \"username\": \"yevhenii.siryi\", \"password\": \"ysiryi\", \"email\": \"yevhenii.siryi@example.com\"}"))
                .andExpect(status().isOk());
    }
}
