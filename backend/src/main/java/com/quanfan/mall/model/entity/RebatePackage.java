package com.quanfan.mall.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("qf_rebate_package")
public class RebatePackage {
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 套餐名称 */
    private String name;

    /** 套餐总价（分） */
    private Long totalPrice;

    /** 套餐封面 */
    private String coverImg;

    /** 套餐描述 */
    private String description;

    /** 状态：0=下架 1=上架 */
    private Integer status;

    /** 创建者（编辑ID） */
    private Long editorId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
