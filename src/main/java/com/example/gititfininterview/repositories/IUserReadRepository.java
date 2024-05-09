package com.example.gititfininterview.repositories;

import com.gitittech.paygo.commons.entities.JpaUser;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IUserReadRepository extends JpaRepository<JpaUser, String> {

    public Optional<JpaUser> findByPhone(String phone);
    
    public Optional<JpaUser> findByEmail(String email);
    
    public Optional<JpaUser> findByEmailOrPhoneOrBvn(String email, String phone, String bvn);
    
}
