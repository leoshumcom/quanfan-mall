package com.quanfan.mall.controller;

import com.quanfan.mall.model.enums.RebateModeEnum;
import com.quanfan.mall.model.vo.Result;
import com.quanfan.mall.service.RebateWheelService;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/wheel")
public class WheelController {

    @GetMapping("/info")
    public Result<?> info() {
        Map<String, Object> rules = new HashMap<>();
        rules.put("cash", Map.of("name", "现金全返", "probability", "15%"));
        rules.put("cashPoints", Map.of("name", "现金+返点", "probability", "35%"));
        rules.put("points", Map.of("name", "纯返点", "probability", "50%"));
        return Result.success(Map.of(
                "rules", rules,
                "tip", "100%中奖，人人全返！"
        ));
    }

    @PostMapping("/spin")
    public Result<?> spin(@RequestBody Map<String, Object> body) {
        long amount = Long.parseLong(body.getOrDefault("amount", "100000").toString());
        RebateModeEnum mode = RebateWheelService.spin();

        String modeName;
        long cash;
        long points;

        switch (mode) {
            case CASH:
                modeName = "现金全返";
                cash = amount;
                points = 0;
                break;
            case CASH_POINTS:
                modeName = "现金+返点";
                cash = amount / 2;
                points = amount / 2;
                break;
            default:
                modeName = "纯返点";
                cash = 0;
                points = amount;
                break;
        }

        Map<String, Object> result = new HashMap<>();
        result.put("mode", mode.getValue());
        result.put("modeName", modeName);
        result.put("cash", cash);
        result.put("points", points);
        result.put("amount", amount);
        result.put("message", "恭喜获得【" + modeName + "】！");
        return Result.success(result);
    }
}
