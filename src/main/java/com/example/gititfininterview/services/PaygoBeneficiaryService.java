package com.example.gititfininterview.services;

import com.example.gititfininterview.repositories.IPaygoBeneficiaryRepository;
import com.example.gititfininterview.repositories.IUserBeneficiaryRepository;
import com.example.gititfininterview.repositories.IUserReadRepository;
import com.example.gititfininterview.requests.CreatePaygoBeneficiaryRequest;
import com.example.gititfininterview.utils.JpaPayGoBeneficiarySpec;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gitittech.paygo.commons.dtos.PaygoBeneficiary;
import com.gitittech.paygo.commons.dtos.Task;
import com.gitittech.paygo.commons.entities.JpaPaygoBeneficiary;
import com.gitittech.paygo.commons.entities.JpaTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.BiFunction;

@Service("paygo")
public class PaygoBeneficiaryService implements IBeneficiary<PaygoBeneficiary> {

  final private IUser userService;
  final private IPaygoBeneficiaryRepository repository;
  final private IUserBeneficiaryRepository userBeneficiaryRepository;
  final private IUserReadRepository userReadRepository;
  final private IBackgroundJob taskService;

  @Autowired
  public PaygoBeneficiaryService(IUser userService,
                                 IUserBeneficiaryRepository userBeneficiaryRepository,
                                 IUserReadRepository userReadRepository,
                                 IBackgroundJob taskService,
                                 IPaygoBeneficiaryRepository readRepository) {
    this.userService = userService;
    this.repository = readRepository;
    this.userBeneficiaryRepository = userBeneficiaryRepository;
    this.userReadRepository = userReadRepository;
    this.taskService = taskService;
  }

  @Override
  public Page<PaygoBeneficiary> getAllBeneficiaries(Boolean isSearch, String filter, Integer page, Integer size, String direction, List<String> properties) throws Throwable {
    PageRequest request = PageRequest.of(page, size, Sort.Direction.valueOf(direction), String.valueOf(properties));

    Specification<JpaPaygoBeneficiary> spec = null;

    if(isSearch){
      spec = JpaPayGoBeneficiarySpec.filter(filter);

    }
    return this.repository.search(spec, request);
  }

  @Override
  public Task createOrLinkBenefiaries(List<PaygoBeneficiary> beneficiaries, String taskId) throws Throwable {
    ObjectMapper objectMapper = new ObjectMapper();
    String JSONString = objectMapper.writeValueAsString(beneficiaries);
    Task task = new Task("NEW_TASK", JSONString);
    task.setId(taskId);

    JpaTask jpaTask = this.taskService.persistTask(task);

    task.setStatus(jpaTask.getStatus());
    task.setJsonData(jpaTask.getJsonData());
    task.setId(jpaTask.getId());
    return task;
  }

  @Override
  public List<PaygoBeneficiary> mapRequestToPayGoBeneficiary(CreatePaygoBeneficiaryRequest phones) {

    List<PaygoBeneficiary> payGoBeneficiaries = new ArrayList<>();

    for (String phone : phones.phones()) {

      Optional<JpaPaygoBeneficiary> beneficiary = this.repository.findByPhone(phone);

      PaygoBeneficiary paygoBeneficiary = new PaygoBeneficiary();

      if (beneficiary.isPresent()) {
        JpaPaygoBeneficiary jpaPaygoBeneficiary = beneficiary.get();
        paygoBeneficiary.setPhone(jpaPaygoBeneficiary.getPhone());
        paygoBeneficiary.setName(jpaPaygoBeneficiary.getName());
        payGoBeneficiaries.add(paygoBeneficiary);
      }

    }

    return payGoBeneficiaries;

  }


  @Override
  public String getTaskStatus(String taskId) throws Throwable {
    Task task = this.taskService.getTask(taskId);

    return task.getStatus();
  }

  @Override
  public <T, U, R> void runTask(BiFunction<T, U, R> func, T t, U u) {
    this.taskService.executeTask(func, t, u);
  }

}
