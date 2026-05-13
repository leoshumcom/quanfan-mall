package com.quanfan.mall.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("qf_travel_route")
public class TravelRoute {
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 线路名称 */
    private String name;

    /** 封面图 */
    private String coverImg;

    /** 图文介绍 */
    @TableField("content_html")
    private String contentHtml;

    /** 视频链接 */
    private String videoUrl;

    /** 出发地 */
    private String departure;

    /** 目的地 */
    private String destination;

    /** 行程天数 */
    private Integer days;

    /** 成团人数 */
    private Integer minGroupSize;

    /** 当前报名人数 */
    private Integer currentSignups;

    /** 费用（分） */
    private Long price;

    /** 状态：0=下架 1=上架 2=已成团 3=已出发 */
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
