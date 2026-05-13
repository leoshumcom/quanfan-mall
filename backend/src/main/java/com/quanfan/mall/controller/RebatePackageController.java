package com.quanfan.mall.controller;

import com.quanfan.mall.model.entity.RebatePackage;
import com.quanfan.mall.model.entity.RebatePackageItem;
import com.quanfan.mall.model.vo.Result;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/api/package")
public class RebatePackageController {

    @GetMapping("/list")
    public Result<?> list() {
        RebatePackage p1 = new RebatePackage();
        p1.setId(1L);
        p1.setName("优选全返套餐A");
        p1.setTotalPrice(100000L);
        p1.setCoverImg("https://via.placeholder.com/300");
        p1.setDescription("包含精选商品组合，价值1000元");
        p1.setStatus(1);

        RebatePackage p2 = new RebatePackage();
        p2.setId(2L);
        p2.setName("超值全返套餐B");
        p2.setTotalPrice(100000L);
        p2.setCoverImg("https://via.placeholder.com/300");
        p2.setDescription("高端商品组合，价值1000元");
        p2.setStatus(1);

        return Result.success(Arrays.asList(p1, p2));
    }

    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        RebatePackage pkg = new RebatePackage();
        pkg.setId(id);
        pkg.setName("优选全返套餐A");
        pkg.setTotalPrice(100000L);
        pkg.setDescription("包含精选商品组合，价值1000元");
        pkg.setStatus(1);

        RebatePackageItem item1 = new RebatePackageItem();
        item1.setProductName("精选大米5kg");
        item1.setProductPrice(30000L);
        item1.setQuantity(2);

        RebatePackageItem item2 = new RebatePackageItem();
        item2.setProductName("食用油1.8L");
        item2.setProductPrice(20000L);
        item2.setQuantity(1);

        return Result.success(pkg);
    }
}
