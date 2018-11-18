-- -----------------------------------------------------
-- Table 创建支付流水表
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_transaction` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_id` VARCHAR(32) NOT NULL COMMENT '应用id',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式id，可以用来识别支付，如：支付宝、微信、Paypal等',
  `transaction_no` VARCHAR(64) NOT NULL COMMENT '本次交易唯一id，整个支付系统唯一，生成他的原因主要是 order_id对于其它应用来说可能重复',
  `order_id` VARCHAR(64) NOT NULL COMMENT '订单号',
  `total_fee` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付金额，整数方式保存',
  `scale` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '金额对应的小数位数',
  `currency_code` CHAR(3) NOT NULL DEFAULT 'CNY' COMMENT '交易的币种',
  `pay_channel` VARCHAR(64) NOT NULL COMMENT '选择的支付渠道，比如：支付宝中的花呗、信用卡等',
  `expire_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单过期时间',
  `return_url` VARCHAR(255) NOT NULL COMMENT '支付后跳转url',
  `notify_url` VARCHAR(255) NOT NULL COMMENT '支付后，异步通知url',
  `email` VARCHAR(64) NOT NULL COMMENT '用户的邮箱',
  `sing_type` VARCHAR(10) NOT NULL DEFAULT 'RSA' COMMENT '采用的签方式：MD5 RSA RSA2 HASH-MAC等',
  `intput_charset` CHAR(5) NOT NULL DEFAULT 'UTF-8' COMMENT '字符集编码方式',
  `payment_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '第三方支付成功的时间',
  `notify_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '通知自己系统的时间',
  `trade_no` VARCHAR(64) NOT NULL COMMENT '第三方的流水号',
  `transaction_code` VARCHAR(64) NOT NULL COMMENT '真实给第三方的交易code，异步通知的时候更新',
  `order_status` TINYINT NOT NULL DEFAULT 0 COMMENT '0:等待支付，1:待付款完成， 2:完成支付，3:该笔交易已关闭，-1:支付失败',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `create_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建的ip，这可能是自己服务的ip',
  `update_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新的ip',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uniq_app_order` (`app_id`, `order_id`),
  UNIQUE INDEX `uniq_trancationno` (`transaction_no`),
  INDEX `idx_trade_no` (`trade_no`),
  INDEX `idx_time` (`create_at`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '发起支付的数据';

-- -----------------------------------------------------
-- Table 交易扩展表
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_transaction_extension` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_no` VARCHAR(64) NOT NULL COMMENT '系统唯一交易id',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `transaction_code` VARCHAR(64) NOT NULL COMMENT '生成传输给第三方的订单号',
  `call_num` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '发起调用的次数',
  `extension_data` TEXT NOT NULL COMMENT '扩展内容，需要保存：transaction_code 与 trade no 的映射关系，异步通知的时候填充',
  `pay_status` ENUM('paid', 'unpaid') NOT NULL DEFAULT 'unpaid' COMMENT '支付状态',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `create_ip` INT UNSIGNED NOT NULL COMMENT '创建ip',
  PRIMARY KEY (`id`),
  INDEX `idx_transaction` (`transaction_no`, `pay_status`),
  UNIQUE INDEX `uniq_code` (`transaction_code`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '交易扩展表';

-- -----------------------------------------------------
-- Table 交易日志表
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_transaction_log` (
  `id` BIGINT UNSIGNED NOT NULL,
  `app_id` VARCHAR(32) NOT NULL COMMENT '应用id',
  `order_id` VARCHAR(64) NOT NULL COMMENT '订单号',
  `request_header` TEXT NOT NULL COMMENT '请求的header 头',
  `request_params` TEXT NOT NULL COMMENT '支付的请求参数',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `create_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建ip',
  PRIMARY KEY (`id`),
  INDEX `idx_app_order` (`app_id`, `order_id`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '交易日志表';


-- -----------------------------------------------------
-- Table 重复支付的交易
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_repeat_transaction` (
  `id` BIGINT UNSIGNED NOT NULL,
  `app_id` VARCHAR(32) NOT NULL COMMENT '应用的id',
  `transaction_no` VARCHAR(64) NOT NULL COMMENT '系统唯一识别交易号',
  `order_id` VARCHAR(64) NOT NULL COMMENT '对应的订单',
  `transaction_code` VARCHAR(64) NOT NULL COMMENT '支付成功时，该笔交易的 code',
  `trade_no` VARCHAR(64) NOT NULL COMMENT '第三方对应的交易号',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式',
  `total_fee` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易金额',
  `scale` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '小数位数',
  `currency_code` CHAR(3) NOT NULL DEFAULT 'CNY' COMMENT '支付选择的币种，CNY、HKD、USD等',
  `payment_time` INT NOT NULL COMMENT '第三方交易时间',
  `repeat_type` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '重复类型：1同渠道支付、2不同渠道支付',
  `source_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '操纵源ip',
  `repeat_status` TINYINT UNSIGNED DEFAULT 0 COMMENT '处理状态,0:未处理；1:已处理',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_at` INT UNSIGNED NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_transaction` (`app_id`, `transaction_no`),
  INDEX `idx_method` (`method_id`),
  INDEX `idx_time` (`create_at`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '记录重复支付';


-- -----------------------------------------------------
-- Table 第三方异步通知日志表
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_third_notify_log` (
  `id` BIGINT UNSIGNED NOT NULL,
  `notify_no` VARCHAR(64) NOT NULL COMMENT '异步通知时该类型的唯一识别码',
  `notify_type` VARCHAR(10) NOT NULL COMMENT '通知类型，paid/refund/canceled/return',
  `header_params` TEXT NOT NULL COMMENT '通知时，对方的header头信息',
  `notify_params` TEXT NOT NULL COMMENT '通知的数据',
  `request_ip` INT UNSIGNED NOT NULL COMMENT '请求的ip',
  `create_at` INT UNSIGNED NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  INDEX `idx_notify` (`notify_no`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '第三方通知的记录';


-- -----------------------------------------------------
-- Table 通知调用方日志
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_notify_app_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_id` VARCHAR(32) NOT NULL COMMENT '应用id',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式',
  `transaction_no` VARCHAR(64) NOT NULL COMMENT '交易号',
  `transaction_code` VARCHAR(64) NOT NULL COMMENT '支付成功时，该笔交易的 code',
  `order_id` VARCHAR(64) NOT NULL COMMENT '订单号',
  `sign_type` VARCHAR(10) NOT NULL DEFAULT 'RSA' COMMENT '采用的签名方式：MD5 RSA RSA2 HASH-MAC等',
  `input_charset` CHAR(5) NOT NULL DEFAULT 'UTF-8',
  `total_fee` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '涉及的金额，无小数',
  `scale` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '小数位数',
  `pay_channel` VARCHAR(64) NOT NULL COMMENT '支付渠道',
  `trade_no` VARCHAR(64) NOT NULL COMMENT '第三方交易号',
  `payment_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付时间',
  `notify_type` VARCHAR(10) NOT NULL DEFAULT 'paid' COMMENT '通知类型，paid/refund/canceled/return',
  `notify_status` VARCHAR(7) NOT NULL DEFAULT 'INIT' COMMENT '通知支付调用方结果；INIT：未通知； PENDING: 进行中；  SUCCESS：成功；  FAILED：失败',
  `notify_num` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '异步通知次数',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0,
  `update_at` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `idx_transaction` (`transaction_no`),
  INDEX `idx_app` (`app_id`, `notify_status`)
  INDEX `idx_time` (`create_at`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '支付调用方记录';


-- -----------------------------------------------------
-- Table 退款
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_refund` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_id` VARCHAR(64) NOT NULL COMMENT '应用id',
  `transaction_no` VARCHAR(64) NOT NULL COMMENT '交易号',
  `trade_no` VARCHAR(64) NOT NULL COMMENT '第三方交易号',
  `order_id` VARCHAR(64) NOT NULL COMMENT '订单号',
  `refund_no` VARCHAR(64) NOT NULL COMMENT '退款id',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式',
  `pay_channel` VARCHAR(64) NOT NULL COMMENT '选择的支付渠道，比如：支付宝中的花呗、信用卡等',
  `refund_fee` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '退款金额',
  `scale` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '小数位数',
  `refund_reason` VARCHAR(128) NOT NULL COMMENT '退款理由',
  `currency_code` CHAR(3) NOT NULL DEFAULT 'CNY' COMMENT '币种，CNY  USD HKD',
  `refund_type` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '退款类型；0:业务退款；1:重复退款；3:补偿性质退款；4:第三方支付机构退款',
  `refund_method` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '退款方式：1:自动原路返回；2:人工打款（需要银行卡信息）',
  `refund_status` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0未退款；1退款成功；2退款不成功',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `create_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '请求源ip',
  `update_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '请求源ip',
  PRIMARY KEY (`id`),
  INDEX `idx_app_refund` (`app_id`, `refund_no`),
  INDEX `idx_order` (`order_id`),
  INDEX `idx_status` (`refund_status`),
  INDEX `idx_time` (`create_at`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '退款记录';


-- -----------------------------------------------------
-- Table 退款日志
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_refund_log` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_id` VARCHAR(64) NOT NULL COMMENT '应用id',
  `transaction_no` VARCHAR(64) NOT NULL COMMENT '交易id',
  `header_params` TEXT NOT NULL COMMENT '头部请求参数',
  `request_params` TEXT NOT NULL COMMENT '请求参数',
  `request_ip` INT NOT NULL DEFAULT 0 COMMENT '请求的ip',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `create_by` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '员工id',
  PRIMARY KEY (`id`),
  INDEX `idx_transaction` (`transaction_no`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '退款日志';
