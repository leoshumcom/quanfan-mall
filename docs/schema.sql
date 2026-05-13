-- ============================
-- 全返商城 + 旅游系统 数据库表
-- ============================

CREATE DATABASE IF NOT EXISTS quanfan_mall DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE quanfan_mall;

-- 用户表
CREATE TABLE qf_user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(50) COMMENT '昵称',
    phone VARCHAR(20) NOT NULL UNIQUE COMMENT '手机号',
    password VARCHAR(255) NOT NULL COMMENT '密码',
    avatar VARCHAR(500) COMMENT '头像',
    role TINYINT NOT NULL DEFAULT 1 COMMENT '角色 1=用户 2=门店 3=编辑 4=管理员',
    store_id BIGINT DEFAULT NULL COMMENT '关联门店ID',
    cash_balance BIGINT DEFAULT 0 COMMENT '现金余额(分)',
    point_balance BIGINT DEFAULT 0 COMMENT '返点余额',
    total_rebate_cash BIGINT DEFAULT 0 COMMENT '累计返现总额(分)',
    status TINYINT DEFAULT 1 COMMENT '状态',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_delete TINYINT DEFAULT 0,
    INDEX idx_phone (phone),
    INDEX idx_role (role),
    INDEX idx_store (store_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- 门店表
CREATE TABLE qf_store (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT '门店名称',
    contact_phone VARCHAR(20) COMMENT '联系电话',
    address VARCHAR(255) COMMENT '地址',
    detail_address VARCHAR(255) COMMENT '详细地址',
    lng DECIMAL(10,7) COMMENT '经度',
    lat DECIMAL(10,7) COMMENT '纬度',
    business_hours VARCHAR(100) COMMENT '营业时间',
    cover_img VARCHAR(500) COMMENT '门店封面',
    status TINYINT DEFAULT 0 COMMENT '状态 0=待审核 1=正常 2=禁用',
    today_verify_count INT DEFAULT 0 COMMENT '今日核销数',
    admin_id BIGINT COMMENT '管理员ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_delete TINYINT DEFAULT 0,
    INDEX idx_status (status),
    INDEX idx_lbs (lng, lat)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='门店';

-- 全返套餐表
CREATE TABLE qf_rebate_package (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT '套餐名称',
    total_price BIGINT NOT NULL COMMENT '套餐总价(分)',
    cover_img VARCHAR(500) COMMENT '套餐封面',
    description TEXT COMMENT '套餐描述',
    status TINYINT DEFAULT 0 COMMENT '0=下架 1=上架',
    editor_id BIGINT COMMENT '创建编辑ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_delete TINYINT DEFAULT 0,
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='全返套餐';

-- 套餐商品明细
CREATE TABLE qf_rebate_package_item (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    package_id BIGINT NOT NULL COMMENT '套餐ID',
    product_name VARCHAR(100) NOT NULL COMMENT '商品名称',
    product_img VARCHAR(500) COMMENT '商品图片',
    product_price BIGINT NOT NULL COMMENT '商品单价(分)',
    quantity INT DEFAULT 1 COMMENT '数量',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_package (package_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='套餐商品明细';

-- 订单表
CREATE TABLE qf_order (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_no VARCHAR(32) NOT NULL UNIQUE COMMENT '订单编号',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    store_id BIGINT COMMENT '核销门店ID',
    package_id BIGINT COMMENT '套餐ID',
    amount BIGINT NOT NULL COMMENT '订单金额(分)',
    status TINYINT DEFAULT 0 COMMENT '0=待支付 1=已支付待核销 2=已核销 3=已完成 4=已取消',
    verify_code VARCHAR(16) COMMENT '核销码',
    rebate_mode TINYINT COMMENT '1=现金 2=现金+返点 3=返点',
    rebate_cash BIGINT DEFAULT 0 COMMENT '返现现金(分)',
    rebate_points BIGINT DEFAULT 0 COMMENT '返现返点',
    pay_type VARCHAR(10) COMMENT 'cash=现金 point=返点',
    pay_time DATETIME COMMENT '支付时间',
    verify_time DATETIME COMMENT '核销时间',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_delete TINYINT DEFAULT 0,
    INDEX idx_user (user_id),
    INDEX idx_store (store_id),
    INDEX idx_status (status),
    INDEX idx_verify_code (verify_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单';

-- 返点商品表
CREATE TABLE qf_point_product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT '商品名称',
    img VARCHAR(500) COMMENT '商品图片',
    description TEXT COMMENT '描述',
    cash_price BIGINT COMMENT '现金价格(分) null=不支持现金',
    point_price BIGINT NOT NULL COMMENT '返点价格',
    stock INT DEFAULT 0 COMMENT '库存',
    status TINYINT DEFAULT 0 COMMENT '0=下架 1=上架',
    editor_id BIGINT COMMENT '创建编辑ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_delete TINYINT DEFAULT 0,
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='返点商品';

-- 返点兑换记录
CREATE TABLE qf_point_exchange (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL COMMENT '用户ID',
    product_id BIGINT NOT NULL COMMENT '商品ID',
    store_id BIGINT COMMENT '核销门店ID',
    quantity INT DEFAULT 1 COMMENT '数量',
    total_points BIGINT NOT NULL COMMENT '消耗返点',
    type VARCHAR(10) NOT NULL COMMENT 'online=线上 order=线下',
    status TINYINT DEFAULT 0 COMMENT '0=待核销 1=已核销 2=已取消',
    verify_code VARCHAR(16) COMMENT '核销码',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    verify_time DATETIME COMMENT '核销时间',
    INDEX idx_user (user_id),
    INDEX idx_store (store_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='返点兑换';

-- 全返规则表
CREATE TABLE qf_rebate_rule (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL COMMENT '规则名称',
    cash_probability INT DEFAULT 15 COMMENT '现金概率(%)',
    cash_point_probability INT DEFAULT 35 COMMENT '现金+返点概率(%)',
    point_probability INT DEFAULT 50 COMMENT '纯返点概率(%)',
    cash_rate INT DEFAULT 100 COMMENT '现金返现比例(%)',
    mixed_cash_rate INT DEFAULT 50 COMMENT '混合模式现金比例(%)',
    daily_cash_limit BIGINT DEFAULT 500000 COMMENT '单日返现上限(分)',
    daily_total_limit BIGINT DEFAULT 5000000 COMMENT '单日返现总限额(分)',
    point_valid_days INT DEFAULT 180 COMMENT '返点有效期(天)',
    withdraw_threshold BIGINT DEFAULT 10000 COMMENT '提现门槛(分)',
    withdraw_fee_rate INT DEFAULT 1 COMMENT '提现手续费率(%)',
    status TINYINT DEFAULT 1 COMMENT '状态',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='全返规则';

-- 旅游线路表
CREATE TABLE qf_travel_route (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT '线路名称',
    cover_img VARCHAR(500) COMMENT '封面图',
    content_html LONGTEXT COMMENT '图文介绍',
    video_url VARCHAR(500) COMMENT '视频链接',
    departure VARCHAR(100) COMMENT '出发地',
    destination VARCHAR(100) COMMENT '目的地',
    days INT COMMENT '行程天数',
    min_group_size INT DEFAULT 20 COMMENT '成团人数',
    current_signups INT DEFAULT 0 COMMENT '当前报名人数',
    price BIGINT COMMENT '费用(分)',
    status TINYINT DEFAULT 0 COMMENT '0=下架 1=上架 2=已成团 3=已出发',
    editor_id BIGINT COMMENT '创建编辑ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_delete TINYINT DEFAULT 0,
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='旅游线路';

-- 旅游报名表
CREATE TABLE qf_travel_signup (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    route_id BIGINT NOT NULL COMMENT '线路ID',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    phone VARCHAR(20) NOT NULL COMMENT '手机号',
    store_id BIGINT COMMENT '推荐门店ID',
    status TINYINT DEFAULT 0 COMMENT '0=已预约待付款 1=已付款已报名 2=已取消',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_route (route_id),
    INDEX idx_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='旅游报名';

-- 资金流水表
CREATE TABLE qf_transaction (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL COMMENT '用户ID',
    type VARCHAR(20) NOT NULL COMMENT '类型: rebate_cash/rebate_point/exchange_point/withdraw/travel_pay',
    amount BIGINT NOT NULL COMMENT '金额(分)',
    balance_before BIGINT COMMENT '变动前余额',
    balance_after BIGINT COMMENT '变动后余额',
    order_id BIGINT COMMENT '关联订单ID',
    remark VARCHAR(255) COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_user (user_id),
    INDEX idx_type (type),
    INDEX idx_create (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资金流水';

-- 插入默认全返规则
INSERT INTO qf_rebate_rule (name, cash_probability, cash_point_probability, point_probability)
VALUES ('默认规则', 15, 35, 50);
