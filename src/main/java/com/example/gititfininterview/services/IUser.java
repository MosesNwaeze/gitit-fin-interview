package com.example.gititfininterview.services;

import com.example.gititfininterview.requests.RegisterRequest;
import com.gitittech.paygo.commons.dtos.User;
import com.gitittech.paygo.commons.dtos.UserWithToken;
import com.gitittech.paygo.commons.entities.JpaUser;
import java.util.Optional;

public interface IUser {
    void requestEmailVerification(String email) throws Throwable;

    User signup(RegisterRequest user) throws Throwable;

    UserWithToken signin(String email, String phone, String bvn, String password) throws Throwable;
   
    void confirmEmail(String email, String code)
            throws Throwable;
                  
    Optional<User> getUserProfile() throws Throwable;
    
    Optional<JpaUser> getJpaUser() throws Throwable;
}