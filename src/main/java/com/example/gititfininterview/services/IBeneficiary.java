package com.example.gititfininterview.services;


import com.example.gititfininterview.requests.CreatePaygoBeneficiaryRequest;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.gitittech.paygo.commons.dtos.Task;
import com.gitittech.paygo.commons.entities.JpaPaygoBeneficiary;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.function.BiFunction;

public interface IBeneficiary<S> {

    Task createOrLinkBenefiaries(List<S> beneficiaries, String taskId) throws Throwable;

    Page<S> getAllBeneficiaries(Boolean isSearch, String filter, Integer page,
            Integer size, String direction, List<String> properties) throws Throwable;

    List<S> mapRequestToPayGoBeneficiary(CreatePaygoBeneficiaryRequest phones);

    String getTaskStatus(String taskId) throws Throwable;

  <T,U,R> void runTask(BiFunction<T, U, R> func, T t, U u);

}
