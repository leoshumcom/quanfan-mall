package com.quanfan.mall.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("qf_order")
public class Order {
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 订单编号 */
    private String orderNo;

    private Long userId;

    /** 核销门店ID */
    private Long storeId;

    /** 套餐ID */
    private Long packageId;

    /** 订单金额（分） */
    private Long amount;

    /** 状态：0=待支付 1=已支付待核销 2=已核销 3=已完成 4=已取消 */
    private Integer status;

    /** 核销码 */
    private String verifyCode;

    /** 全返模式：1=现金 2=现金+返点 3=返点 */
    private Integer rebateMode;

    /** 返现现金（分） */
    private Long rebateCash;

    /** 返现返点 */
    private Long rebatePoints;

    /** 支付类型：cash=现金 point=返点 */
    private String payType;

    /** 支付时间 */
    private LocalDateTime payTime;

    /** 核销时间 */
    private LocalDateTime verifyTime;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
