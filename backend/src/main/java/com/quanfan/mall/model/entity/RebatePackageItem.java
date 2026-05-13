package com.quanfan.mall.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("qf_rebate_package_item")
public class RebatePackageItem {
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 套餐ID */
    private Long packageId;

    /** 商品名称 */
    private String productName;

    /** 商品图片 */
    private String productImg;

    /** 商品单价（分） */
    private Long productPrice;

    /** 数量 */
    private Integer quantity;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}
