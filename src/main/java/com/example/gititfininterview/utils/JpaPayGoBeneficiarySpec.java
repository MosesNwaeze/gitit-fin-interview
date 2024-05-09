package com.example.gititfininterview.utils;

import com.gitittech.paygo.commons.entities.JpaPaygoBeneficiary;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.Predicate;

public class JpaPayGoBeneficiarySpec {

   private static final String PHONE = "phone";
   private static final String NAME = "name";

   private JpaPayGoBeneficiarySpec(){};


  public static Specification<JpaPaygoBeneficiary> filter(String filter) {
    return (root, query, criteriaBuilder) -> {
      Predicate brandPredicate =
        criteriaBuilder.like(root.get("phone"), StringUtils.isBlank(filter)
          ? likePattern() : filter);
      Predicate namePredicate =
        criteriaBuilder.like(root.get("name"), StringUtils.isBlank(filter)
          ? likePattern() : filter);
      return criteriaBuilder.or(namePredicate, brandPredicate);
    };
  }

  private static String likePattern() {
    return "%" + "" + "%";
  }

}
