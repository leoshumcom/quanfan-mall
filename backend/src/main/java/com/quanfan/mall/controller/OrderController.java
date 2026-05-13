package com.quanfan.mall.controller;

import com.quanfan.mall.model.entity.Order;
import com.quanfan.mall.model.vo.Result;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/order")
public class OrderController {

    @PostMapping("/create")
    public Result<?> create(@RequestBody Map<String, Object> body) {
        Order order = new Order();
        order.setId(1L);
        order.setOrderNo(UUID.randomUUID().toString().substring(0, 16));
        order.setUserId(Long.valueOf(body.getOrDefault("userId", 1).toString()));
        order.setPackageId(Long.valueOf(body.getOrDefault("packageId", 1).toString()));
        order.setAmount(100000L);
        order.setStatus(0);
        order.setVerifyCode(UUID.randomUUID().toString().substring(0, 8));
        order.setCreateTime(LocalDateTime.now());
        return Result.success(order);
    }

    @GetMapping("/list")
    public Result<?> list(@RequestParam(defaultValue = "1") Long userId) {
        Order order = new Order();
        order.setId(1L);
        order.setOrderNo("QF202605130001");
        order.setUserId(userId);
        order.setAmount(100000L);
        order.setStatus(0);
        order.setCreateTime(LocalDateTime.now());
        return Result.success(java.util.List.of(order));
    }

    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        Order order = new Order();
        order.setId(id);
        order.setOrderNo("QF202605130001");
        order.setAmount(100000L);
        order.setStatus(2);
        order.setCreateTime(LocalDateTime.now());
        order.setVerifyTime(LocalDateTime.now());
        return Result.success(order);
    }
}
