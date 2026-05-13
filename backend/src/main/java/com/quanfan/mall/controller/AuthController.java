package com.quanfan.mall.controller;

import com.quanfan.mall.model.vo.Result;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @PostMapping("/register")
    public Result<?> register(@RequestBody Map<String, String> body) {
        String phone = body.get("phone");
        if (phone == null || phone.isEmpty()) {
            return Result.fail("手机号不能为空");
        }
        return Result.success(Map.of("userId", 1, "phone", phone));
    }

    @PostMapping("/login")
    public Result<?> login(@RequestBody Map<String, String> body) {
        String phone = body.get("phone");
        String password = body.get("password");
        if (phone == null || password == null) {
            return Result.fail("手机号或密码不能为空");
        }
        String token = UUID.randomUUID().toString().replace("-", "");
        return Result.success(Map.of(
                "token", token,
                "userId", 1,
                "role", 1,
                "nickname", "测试用户"
        ));
    }
}
