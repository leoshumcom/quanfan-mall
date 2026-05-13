package com.quanfan.mall.controller;

import com.quanfan.mall.model.entity.Store;
import com.quanfan.mall.model.vo.Result;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/store")
public class StoreController {

    @GetMapping("/nearby")
    public Result<?> nearby(@RequestParam(defaultValue = "0") double lng,
                            @RequestParam(defaultValue = "0") double lat) {
        List<Store> stores = new ArrayList<>();

        Store s1 = new Store();
        s1.setId(1L);
        s1.setName("全返旗舰店（浦东）");
        s1.setAddress("上海市浦东新区张江路100号");
        s1.setContactPhone("021-88886666");
        s1.setBusinessHours("09:00-21:00");
        stores.add(s1);

        Store s2 = new Store();
        s2.setId(2L);
        s2.setName("全返体验店（徐汇）");
        s2.setAddress("上海市徐汇区漕溪路200号");
        s2.setContactPhone("021-88887777");
        s2.setBusinessHours("09:00-20:00");
        stores.add(s2);

        return Result.success(stores);
    }
}
