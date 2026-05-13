package com.quanfan.mall.controller;

import com.quanfan.mall.model.entity.PointProduct;
import com.quanfan.mall.model.vo.Result;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/api/point-product")
public class PointProductController {

    @GetMapping("/list")
    public Result<?> list() {
        PointProduct p1 = new PointProduct();
        p1.setId(1L);
        p1.setName("东北五常大米 5kg");
        p1.setImg("https://via.placeholder.com/200");
        p1.setCashPrice(5000L);
        p1.setPointPrice(8000L);
        p1.setStock(100);
        p1.setStatus(1);

        PointProduct p2 = new PointProduct();
        p2.setId(2L);
        p2.setName("非转基因食用油 1.8L");
        p2.setImg("https://via.placeholder.com/200");
        p2.setCashPrice(4000L);
        p2.setPointPrice(6000L);
        p2.setStock(50);
        p2.setStatus(1);

        return Result.success(Arrays.asList(p1, p2));
    }

    @PostMapping("/exchange")
    public Result<?> exchange(@RequestBody java.util.Map<String, Object> body) {
        Long productId = Long.valueOf(body.get("productId").toString());
        Integer quantity = Integer.valueOf(body.getOrDefault("quantity", "1").toString());

        return Result.success(java.util.Map.of(
                "exchangeId", 1L,
                "productId", productId,
                "quantity", quantity,
                "totalPoints", 8000 * quantity,
                "verifyCode", "EX" + System.currentTimeMillis() % 1000000,
                "message", "兑换成功，请到门店核销取货"
        ));
    }
}
