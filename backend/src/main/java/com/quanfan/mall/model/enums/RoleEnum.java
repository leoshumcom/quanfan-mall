package com.quanfan.mall.model.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;

public enum RoleEnum {
    USER(1, "用户"),
    STORE(2, "门店"),
    EDITOR(3, "编辑"),
    ADMIN(4, "管理员");

    @EnumValue
    private final int value;
    private final String name;

    RoleEnum(int value, String name) {
        this.value = value;
        this.name = name;
    }

    public int getValue() { return value; }
    public String getName() { return name; }
}
