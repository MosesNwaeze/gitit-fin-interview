package com.example.gititfininterview;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@ComponentScans({
    @ComponentScan("com.example.gititfininterview"),
    @ComponentScan("com.gitittech.paygo")
})
@EntityScan(basePackages = {"com.gitittech.paygo.commons.entities"})
@EnableJpaRepositories(basePackages = {
    "com.example.gititfininterview.repositories",
    "com.gitittech.paygo.settings",
    "com.gitittech.paygo.user",
    "com.gitittech.paygo.auth",
    "com.gitittech.paygo.beneficiary",
    "com.gitittech.paygo.message",
    "com.gitittech.paygo.transaction",
    "com.gitittech.paygo.paymentmethod"
})
@EnableAsync
@EnableTransactionManagement
@SpringBootApplication
public class GititFinInterviewApplication {

    public static void main(String[] args) {
        SpringApplication.run(GititFinInterviewApplication.class, args);
    }

}
