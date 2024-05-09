/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.gititfininterview.services;

import com.gitittech.paygo.commons.dtos.Task;
import com.gitittech.paygo.commons.entities.JpaTask;

import java.util.Optional;
import java.util.function.BiFunction;

/**
 *
 * @author Ambrose Ariagiegbe
 */
public interface IBackgroundJob {

    Task getTask(String id) throws Throwable;

    <T,U,R> Task executeTask(BiFunction<T,U,R> func, T t, U u);

    JpaTask persistTask(Task task);
}
