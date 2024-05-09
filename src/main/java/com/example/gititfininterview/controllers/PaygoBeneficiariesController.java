package com.example.gititfininterview.controllers;

import com.example.gititfininterview.requests.CreatePaygoBeneficiaryRequest;
import com.example.gititfininterview.services.IBeneficiary;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gitittech.paygo.commons.dtos.PaygoBeneficiary;
import com.gitittech.paygo.commons.dtos.Task;
import com.gitittech.paygo.commons.entities.JpaPaygoBeneficiary;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;
import java.util.function.BiFunction;

@RestController
@RequestMapping("/paygo_beneficiaries")
public class PaygoBeneficiariesController {

  private final IBeneficiary paygoBeneficiaryService;
  private Task task;

  @Autowired
  public PaygoBeneficiariesController(@Qualifier("paygo") IBeneficiary paygoBeneficiaryService) {
    this.paygoBeneficiaryService = paygoBeneficiaryService;
  }

  @GetMapping("/")
  @SecurityRequirement(name = "Bearer Authentication")
  public ResponseEntity<?> getPaygoBeneficiaries(
    @RequestParam(value = "isSearch", defaultValue = "false") Boolean isSearch,
    @RequestParam(value = "filter", defaultValue = "") String filter,
    @RequestParam(value = "page", defaultValue = "0") Integer page,
    @RequestParam(value = "size", defaultValue = "20") Integer size,
    @RequestParam(value = "direction", defaultValue = "DESC") String direction,
    @RequestParam(value = "property") List<String> properties) throws Throwable {
    return ResponseEntity.ok(paygoBeneficiaryService.getAllBeneficiaries(isSearch, filter, page, size, direction, properties));
  }

  @GetMapping("{taskId}")
  public ResponseEntity<String> getTaskStatus(@Valid @PathVariable("taskId") String taskId) throws Throwable {
    return ResponseEntity.ok(this.paygoBeneficiaryService.getTaskStatus(taskId));
  }

  @PostMapping("/")
  @SecurityRequirement(name = "Bearer Authentication")
  public ResponseEntity<String> createBeneificiaries(final @RequestBody @Valid CreatePaygoBeneficiaryRequest request) throws Throwable {
    String taskId = UUID.randomUUID().toString();
    List<PaygoBeneficiary> beneficiary = this.paygoBeneficiaryService.mapRequestToPayGoBeneficiary(request);
    setTask(this.paygoBeneficiaryService.createOrLinkBenefiaries(beneficiary, taskId));
    runTask();
    return ResponseEntity.ok(taskId);
  }

  public Task getTask() {
    return this.task;
  }

  public void setTask(Task task) {
    this.task = task;
  }

  private void runTask() {

    Comparator<JpaPaygoBeneficiary> comparator = Comparator.comparingInt((JpaPaygoBeneficiary a) -> Integer.parseInt(a.getPhone()));

    BiFunction<Task, Comparator<JpaPaygoBeneficiary>, List<JpaPaygoBeneficiary>> func =
      (task1, compareFunc) -> {

        ObjectMapper objectMapper = new ObjectMapper();
        List<JpaPaygoBeneficiary> beneficiaries = null;
        try {
          beneficiaries = objectMapper.readValue(task1.getJsonData(), new TypeReference<>() {
          });

          beneficiaries.sort(compareFunc);

        } catch (JsonProcessingException e) {
          throw new RuntimeException(e);
        }

        return beneficiaries;
      };

    this.paygoBeneficiaryService.runTask(func, this.getTask(), comparator);


  }
}
