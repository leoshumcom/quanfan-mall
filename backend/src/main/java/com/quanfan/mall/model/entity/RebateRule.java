package com.quanfan.mall.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("qf_rebate_rule")
public class RebateRule {
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 规则名称 */
    private String name;

    /** 现金概率（百分比） */
    private Integer cashProbability;

    /** 现金+返点概率 */
    private Integer cashPointProbability;

    /** 纯返点概率 */
    private Integer pointProbability;

    /** 现金返现比例（如 100 表示100%全额） */
    private Integer cashRate;

    /** 现金+返点：现金比例（如50表示50%现金+50%返点） */
    private Integer mixedCashRate;

    /** 单日返现上限（分） */
    private Long dailyCashLimit;

    /** 单日返现总限额（分） */
    private Long dailyTotalLimit;

    /** 返点有效期（天） */
    private Integer pointValidDays;

    /** 提现门槛（分） */
    private Long withdrawThreshold;

    /** 提现手续费率（百分比，如1表示1%） */
    private Integer withdrawFeeRate;

    /** 状态 */
    private Integer status;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}
