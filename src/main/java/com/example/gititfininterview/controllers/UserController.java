/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.gititfininterview.controllers;

import com.example.gititfininterview.requests.EmailVerificationRequest;
import com.example.gititfininterview.requests.LoginRequest;
import com.example.gititfininterview.requests.RegisterRequest;
import com.example.gititfininterview.services.IUser;
import com.gitittech.paygo.commons.dtos.User;
import com.gitittech.paygo.commons.dtos.UserWithToken;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

/**
 *
 * @author DoBUY
 */
public class UserController {
       private final IUser userService;

    @Autowired
    public UserController(IUser userService) {
        this.userService = userService;
    }

    @GetMapping("/profile")
    @SecurityRequirement(name = "Bearer Authentication")
    public ResponseEntity<User> getContextUser() throws Exception, Throwable {
        var user = userService.getUserProfile();
        return ResponseEntity.ok(user.get());
    }    
          
    @PostMapping("/signup")    
    public ResponseEntity<User> signup(@RequestBody @Valid RegisterRequest user) throws Exception, Throwable {
        var signedUpUser = userService.signup(user);
        return ResponseEntity.ok(signedUpUser);
    }

    @PostMapping("/auth")
    public ResponseEntity<UserWithToken> signin(@RequestBody @Valid LoginRequest login) throws Throwable {
        final var userWithToken = userService.signin(login.email(), login.phone(), login.bvn(),
                login.password());
        return ResponseEntity.ok(userWithToken);
    }    

    @PutMapping("/verify")
    public ResponseEntity confirmEmail(@RequestBody @Valid EmailVerificationRequest verificationRequest) throws Exception, Throwable {
        userService.confirmEmail(verificationRequest.email(), verificationRequest.code());
        return ResponseEntity.ok().build();
    }       
}
