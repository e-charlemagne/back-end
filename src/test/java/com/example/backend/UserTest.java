package com.example.backend;

import com.example.backend.controllers.UserController;
import com.example.backend.entities.actors.Roles;
import com.example.backend.entities.actors.User;
import com.example.backend.jwt.MyUserDetailsService;
import com.example.backend.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.ResponseEntity;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.*;

public class UserTest {
    @Mock
    private UserRepository userRepository;

    @Mock
    private MyUserDetailsService myUserDetailsService;

    @InjectMocks
    private UserController userController;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetAllUsers() {
        User user1 = new User();
        user1.setUsername("user1");
        User user2 = new User();
        user2.setUsername("user2");

        when(userRepository.findAll()).thenReturn(Arrays.asList(user1, user2));

        List<User> result = userController.getAllUsers();
        assertEquals(2, result.size());
        assertEquals("user1", result.get(0).getUsername());
        assertEquals("user2", result.get(1).getUsername());
    }

    @Test
    public void testGetUserByStatusAsCustomers() {
        User customer = new User();
        Roles customerRole = new Roles();
        customerRole.setRoleName("Customer");
        customer.setRole(customerRole);

        when(userRepository.findByRole_RoleName("Customer")).thenReturn(Arrays.asList(customer));

        List<User> result = userController.getUserByStatusAsCustomers();
        assertEquals(1, result.size());
        assertEquals("Customer", result.get(0).getRole().getRoleName());
    }

    @Test
    public void testAddUser() {
        User user = new User();
        user.setUsername("user");
        when(myUserDetailsService.save(user)).thenReturn(user);

        ResponseEntity<User> response = userController.addUser(user);
        assertEquals(200, response.getStatusCodeValue());
        assertEquals("user", response.getBody().getUsername());
    }


    @Test
    public void testUpdateUser() {
        User user = new User();
        user.setUsername("test");
        user.setFirstname("Test");
        user.setLastname("Test");
        user.setPassword("test");
        user.setEmail("test@test.com");
        Roles role = new Roles();
        role.setRoleName("Customer");
        user.setRole(role);

        when(userRepository.findByUsername("test")).thenReturn(Optional.of(user));

        User updatedUser = new User();
        updatedUser.setFirstname("updated");
        updatedUser.setLastname("Test");
        updatedUser.setPassword("test");
        updatedUser.setEmail("test@test.com");
        updatedUser.setRole(role);

        when(userRepository.save(any(User.class))).thenAnswer(invocation -> invocation.getArgument(0));

        ResponseEntity<User> response = userController.updateUser("test", updatedUser);

        assertEquals(200, response.getStatusCodeValue());
        assertNotNull(response.getBody());
        assertEquals("updated", response.getBody().getFirstname());
    }


    @Test
    public void testDeleteUserByUserName() {
        User user = new User();
        user.setUsername("user");
        when(userRepository.findByUsername("user")).thenReturn(Optional.of(user));

        ResponseEntity<?> response = userController.deleteUserByUserName("user");
        assertEquals(200, response.getStatusCodeValue());
        verify(userRepository, times(1)).deleteByUsername("user");
    }
}
