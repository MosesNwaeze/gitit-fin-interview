package com.example.gititfininterview.repositories;

import com.gitittech.paygo.commons.entities.JpaUserBeneficiary;
import org.springframework.data.jpa.repository.JpaRepository;

@org.springframework.stereotype.Repository
public interface IUserBeneficiaryRepository extends JpaRepository<JpaUserBeneficiary, String>{       
               
}
