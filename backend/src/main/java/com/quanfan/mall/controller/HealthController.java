package com.quanfan.mall.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.Map;

@RestController
public class HealthController {

    @GetMapping({"/", "/api/health"})
    public Map<String, Object> health() {
        return Map.of(
                "status", "UP",
                "service", "quanfan-mall",
                "time", LocalDateTime.now().toString()
        );
    }
}
