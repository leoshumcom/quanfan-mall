package com.quanfan.mall.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("qf_travel_signup")
public class TravelSignup {
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 线路ID */
    private Long routeId;

    private String name;
    private String phone;

    /** 推荐门店ID */
    private Long storeId;

    /** 状态：0=已预约待付款 1=已付款已报名 2=已取消 */
    private Integer status;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}
