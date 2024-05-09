package com.example.gititfininterview.repositories;

import com.gitittech.paygo.commons.dtos.PaygoBeneficiary;
import com.gitittech.paygo.commons.entities.JpaPaygoBeneficiary;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;

@org.springframework.stereotype.Repository
public interface IPaygoBeneficiaryRepository extends JpaRepository<JpaPaygoBeneficiary, String>, JpaSpecificationExecutor<JpaPaygoBeneficiary> {

    Optional<JpaPaygoBeneficiary> findByPhone(String phone);

    Page<PaygoBeneficiary> search(@Nullable Specification<JpaPaygoBeneficiary> spec, @NonNull Pageable pageable);

    List<PaygoBeneficiary> findAllByPhoneOrName(String phone, String name);



}
