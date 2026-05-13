package com.quanfan.mall.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.quanfan.mall.mapper.StoreMapper;
import com.quanfan.mall.model.entity.Store;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Service
public class StoreService extends ServiceImpl<StoreMapper, Store> {

    /**
     * 查找最近的limit家可用门店
     */
    public List<Store> findNearestStores(double lng, double lat, int limit) {
        List<Store> stores = list(new LambdaQueryWrapper<Store>()
                .eq(Store::getStatus, 1));

        List<StoreDistance> withDist = new ArrayList<>();
        for (Store s : stores) {
            double dist = distance(lat, lng, s.getLat(), s.getLng());
            withDist.add(new StoreDistance(s, dist));
        }

        withDist.sort(Comparator.comparingDouble(sd -> sd.distance));
        List<Store> result = new ArrayList<>();
        for (int i = 0; i < Math.min(limit, withDist.size()); i++) {
            result.add(withDist.get(i).store);
        }
        return result;
    }

    private static class StoreDistance {
        Store store;
        double distance;
        StoreDistance(Store store, double distance) {
            this.store = store;
            this.distance = distance;
        }
    }

    private double distance(double lat1, double lng1, double lat2, double lng2) {
        if (lat1 == 0 || lng1 == 0 || lat2 == 0 || lng2 == 0) return Double.MAX_VALUE;
        double radLat1 = Math.toRadians(lat1);
        double radLat2 = Math.toRadians(lat2);
        double a = radLat1 - radLat2;
        double b = Math.toRadians(lng1) - Math.toRadians(lng2);
        double s = 2 * Math.asin(Math.sqrt(
                Math.pow(Math.sin(a / 2), 2) +
                Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)
        ));
        return s * 6371000;
    }
}
