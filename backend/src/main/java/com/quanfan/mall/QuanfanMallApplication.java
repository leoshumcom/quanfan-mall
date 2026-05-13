package com.quanfan.mall;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.quanfan.mall.mapper")
public class QuanfanMallApplication {

    public static void main(String[] args) {
        SpringApplication.run(QuanfanMallApplication.class, args);
    }
}
