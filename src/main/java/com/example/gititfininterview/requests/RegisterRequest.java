package com.example.gititfininterview.requests;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

public record RegisterRequest(
        @NotBlank(message = "Email is mandatory")
        @Email(message = "Email is not correct")
        String email,
        @Size(min = 11, max = 11, message = "BVN must be 11 digits in length")
        String bvn,
        String phone,
        String firstName,
        String middleName,
        String lastName,
        @NotBlank(message = "Password is mandatory")
        @Size(min = 7, message = "Password must be 7 or more in length")        
        String password) {

}
