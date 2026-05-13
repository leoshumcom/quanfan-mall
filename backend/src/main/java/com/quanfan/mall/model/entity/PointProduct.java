package com.quanfan.mall.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("qf_point_product")
public class PointProduct {
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 商品名称 */
    private String name;

    /** 商品图片 */
    private String img;

    /** 描述 */
    private String description;

    /** 现金价格（分），null=不支持现金购买 */
    private Long cashPrice;

    /** 返点价格 */
    private Long pointPrice;

    /** 库存 */
    private Integer stock;

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
