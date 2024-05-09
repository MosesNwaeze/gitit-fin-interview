/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.gititfininterview.services;

import com.example.gititfininterview.repositories.ITaskRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gitittech.paygo.commons.dtos.Task;
import com.gitittech.paygo.commons.entities.JpaTask;
import com.gitittech.paygo.commons.enums.TaskStatus;
import com.gitittech.paygo.commons.exceptions.NotFoundException;
import com.gitittech.paygo.commons.mappers.ITaskMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.function.BiFunction;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Ambrose Ariagiegbe
 */
@Service
public class BackgroundJobImpl implements IBackgroundJob {

  private final ITaskRepository repository;

  @Autowired
  public BackgroundJobImpl(ITaskRepository repository) {
    this.repository = repository;
  }

  @Override
  public Task getTask(String id) throws Throwable {
    final var task = this.repository.findById(id)
      .orElseThrow(() -> new NotFoundException("task was not found"));
    return ITaskMapper.INSTANCE.toTask(task);
  }

  @Override
  public <T, U, R> Task executeTask(BiFunction<T, U, R> func, T t, U u) {

    final var jpaTask = new JpaTask();
    jpaTask.setStatus(TaskStatus.IN_PROGRESS.name());
    this.repository.save(jpaTask);
    try {
      runTask(func, t, u, jpaTask);
    } catch (JsonProcessingException ex) {
      Logger.getLogger(BackgroundJobImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return ITaskMapper.INSTANCE.toTask(jpaTask);
  }

  @Override
  public JpaTask persistTask(Task task) {
    JpaTask jpaTask = new JpaTask();
    jpaTask.setStatus(task.getStatus());
    jpaTask.setJsonData(task.getJsonData());
    jpaTask.setId(task.getId());
    return this.repository.save(jpaTask);
  }

  @Scheduled(fixedDelay = 0)
  private <T, U, R> void runTask(BiFunction<T, U, R> func, T t, U u, JpaTask task) throws JsonProcessingException {
    final R result = func.apply(t, u);
    ObjectMapper objectMapper = new ObjectMapper();
    final var resultString = objectMapper.writeValueAsString(result);
    task.setStatus(TaskStatus.COMPLETED.name());
    task.setJsonData(resultString);
    this.repository.save(task);
  }
}
