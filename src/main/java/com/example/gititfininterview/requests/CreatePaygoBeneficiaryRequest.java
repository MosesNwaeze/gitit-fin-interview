/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.gititfininterview.requests;

import java.util.List;
import javax.validation.constraints.NotNull;

/**
 *
 * @author HP
 */
public record CreatePaygoBeneficiaryRequest(@NotNull(message = "List of phone numbers is mandatory")
        List<String> phones) {
}
