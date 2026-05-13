package com.quanfan.mall.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("qf_store")
public class Store {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;
    private String contactPhone;
    private String address;
    private String detailAddress;

    /** 经度 */
    private Double lng;
    /** 纬度 */
    private Double lat;

    /** 营业时间 */
    private String businessHours;
    private String coverImg;

    /** 状态：0=待审核 1=正常 2=禁用 */
    private Integer status;

    /** 今日核销数 */
    private Integer todayVerifyCount;

    private Long adminId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
