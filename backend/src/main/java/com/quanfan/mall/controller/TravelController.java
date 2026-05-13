package com.quanfan.mall.controller;

import com.quanfan.mall.model.entity.TravelRoute;
import com.quanfan.mall.model.vo.Result;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/travel")
public class TravelController {

    @GetMapping("/routes")
    public Result<?> routes() {
        TravelRoute r1 = new TravelRoute();
        r1.setId(1L);
        r1.setName("云南大理丽江5日游");
        r1.setCoverImg("https://via.placeholder.com/400x200");
        r1.setDeparture("上海");
        r1.setDestination("云南");
        r1.setDays(5);
        r1.setMinGroupSize(20);
        r1.setCurrentSignups(8);
        r1.setPrice(299900L);
        r1.setStatus(1);

        TravelRoute r2 = new TravelRoute();
        r2.setId(2L);
        r2.setName("海南三亚4日自由行");
        r2.setCoverImg("https://via.placeholder.com/400x200");
        r2.setDeparture("上海");
        r2.setDestination("海南");
        r2.setDays(4);
        r2.setMinGroupSize(15);
        r2.setCurrentSignups(12);
        r2.setPrice(199900L);
        r2.setStatus(1);

        return Result.success(Arrays.asList(r1, r2));
    }

    @PostMapping("/signup")
    public Result<?> signup(@RequestBody Map<String, Object> body) {
        Long routeId = Long.valueOf(body.get("routeId").toString());
        String name = (String) body.get("name");
        String phone = (String) body.get("phone");

        return Result.success(Map.of(
                "signupId", 1L,
                "routeId", routeId,
                "name", name,
                "phone", phone,
                "status", 0,
                "message", "报名成功！请到最近门店支付报名费完成报名。"
        ));
    }

    @GetMapping("/signup/{id}")
    public Result<?> signupDetail(@PathVariable Long id) {
        return Result.success(Map.of(
                "id", id,
                "routeName", "云南大理丽江5日游",
                "name", "张三",
                "phone", "13800138000",
                "status", 0,
                "statusName", "已预约待付款",
                "storeName", "全返旗舰店（浦东）",
                "storeAddress", "上海市浦东新区张江路100号"
        ));
    }
}
