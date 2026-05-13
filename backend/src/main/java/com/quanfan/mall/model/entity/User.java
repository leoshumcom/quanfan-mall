package com.quanfan.mall.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("qf_user")
public class User {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String nickname;
    private String phone;
    private String password;
    private String avatar;

    /** 角色：1=用户 2=门店 3=编辑 4=管理员 */
    private Integer role;

    /** 关联门店ID（门店角色时有效） */
    private Long storeId;

    /** 现金余额（可提现） */
    private Long cashBalance;

    /** 返点余额 */
    private Long pointBalance;

    /** 累计返现总额（风控用） */
    private Long totalRebateCash;

    private Integer status;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
