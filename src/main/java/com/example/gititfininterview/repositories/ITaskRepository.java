/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.example.gititfininterview.repositories;

import com.gitittech.paygo.commons.entities.JpaTask;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author Ambrose Ariagiegbe
 */
public interface ITaskRepository extends JpaRepository<JpaTask, String>{
   
}
