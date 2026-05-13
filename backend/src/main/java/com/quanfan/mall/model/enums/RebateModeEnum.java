package com.quanfan.mall.model.enums;

public enum RebateModeEnum {
    CASH(1, "现金全返", 15),
    CASH_POINTS(2, "现金+返点", 35),
    POINTS(3, "纯返点", 50);

    private final int value;
    private final String name;
    /**
     * 默认概率（百分比）
     */
    private final int defaultProbability;

    RebateModeEnum(int value, String name, int defaultProbability) {
        this.value = value;
        this.name = name;
        this.defaultProbability = defaultProbability;
    }

    public int getValue() { return value; }
    public String getName() { return name; }
    public int getDefaultProbability() { return defaultProbability; }

    public static RebateModeEnum fromValue(int value) {
        for (RebateModeEnum mode : values()) {
            if (mode.value == value) return mode;
        }
        throw new IllegalArgumentException("Unknown rebate mode: " + value);
    }
}
