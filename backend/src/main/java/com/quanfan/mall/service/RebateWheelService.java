package com.quanfan.mall.service;

import com.quanfan.mall.model.entity.Order;
import com.quanfan.mall.model.entity.RebateRule;
import com.quanfan.mall.model.enums.RebateModeEnum;

import java.util.Random;

/**
 * 全返大转盘核心逻辑
 */
public class RebateWheelService {

    private static final Random RANDOM = new Random();

    /**
     * 大转盘抽奖，根据概率返回全返模式
     */
    public static RebateModeEnum spin() {
        int roll = RANDOM.nextInt(100) + 1;
        if (roll <= 15) {
            return RebateModeEnum.CASH;
        } else if (roll <= 50) {
            return RebateModeEnum.CASH_POINTS;
        } else {
            return RebateModeEnum.POINTS;
        }
    }

    /**
     * 根据模式和订单金额计算返现结果
     */
    public static RebateResult calculate(Order order, RebateModeEnum mode, RebateRule rule) {
        long amount = order.getAmount();
        RebateResult result = new RebateResult();

        switch (mode) {
            case CASH: {
                long cashRate = rule.getCashRate() != null ? rule.getCashRate() : 100;
                result.setCash(amount * cashRate / 100);
                result.setPoints(0L);
                break;
            }
            case CASH_POINTS: {
                int mixedCashRate = rule.getMixedCashRate() != null ? rule.getMixedCashRate() : 50;
                result.setCash(amount * mixedCashRate / 100);
                result.setPoints(amount * (100 - mixedCashRate) / 100);
                break;
            }
            case POINTS: {
                result.setCash(0L);
                result.setPoints(amount);
                break;
            }
        }
        return result;
    }

    public static class RebateResult {
        private int mode;
        private long cash;
        private long points;

        public RebateResult() {}

        public RebateResult(int mode, long cash, long points) {
            this.mode = mode;
            this.cash = cash;
            this.points = points;
        }

        public int getMode() { return mode; }
        public void setMode(int mode) { this.mode = mode; }
        public long getCash() { return cash; }
        public void setCash(long cash) { this.cash = cash; }
        public long getPoints() { return points; }
        public void setPoints(long points) { this.points = points; }
    }
}
