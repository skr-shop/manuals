# [Skr-Shop]通用抽奖工具之系统设计

## DB设计

```sql
-- 通用抽奖工具(万能胶Glue) glue_activity 抽奖活动表
CREATE TABLE `glue_activity` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '活动ID',
    `serial_no` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '活动名称',
    `name` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '活动名称',
    `description` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '活动描述',
    `probability_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '中奖概率类型1: static 2: dynamic',
    `times_limit` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '抽奖次数限制，0默认不限制',
    `start_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动开始时间',
    `end_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动结束时间',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动表';

-- 通用抽奖工具(万能胶Glue) glue_session 抽奖场次表
CREATE TABLE `glue_session` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '场次ID',
    `activity_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动ID',
    `times_limit` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '抽奖次数限制，0默认不限制',
    `start_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '场次开始时间',
    `end_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '场次结束时间',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖场次表';

-- 通用抽奖工具(万能胶Glue) glue_session_prizes 抽奖场次奖品表
CREATE TABLE `glue_session_prizes` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `session_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '场次ID',
    `prize_type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '奖品类型 1:优惠券, 2:积分, 3:实物, 4:空奖 ...',
    `name` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '奖品名称',
    `pic_url` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '奖品图片',
    `value` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '奖品抽象值 优惠券:优惠券ID, 积分:积分值, 实物: sku ID',
    `probability` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '中奖概率1~100',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖场次奖品表';

-- 通用抽奖工具(万能胶Glue) glue_session_prizes_timer 抽奖场次奖品定时投放器表
CREATE TABLE `glue_session_prizes_timer` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `session_prizes_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '抽奖场次奖品ID',
    `delivery_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '定时投放奖品数量的时间',
    `prize_quantity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '奖品数量',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖场次奖品定时投放器表';

-- 通用抽奖工具(万能胶Glue) glue_user_draw_record 用户抽奖记录表
CREATE TABLE `glue_user_draw_record` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `activity_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动ID',
    `session_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '场次ID',
    `prize_type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '奖品类型ID',
    `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人user_id',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 -1:未中奖, 1:已中奖 , 2: 发奖失败 , 3: 已发奖',
    `log` text COMMENT '操作信息等记录',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户抽奖记录表';
```

## 配置后台设计

#### 创建活动

<p align="center">
    <a href="http://cdn.tigerb.cn/20191229161010.jpg?imageMogr2/thumbnail/1934x1567!/format/webp/blur/1x0/quality/75|imageslim" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20191229161010.jpg?imageMogr2/thumbnail/1934x1567!/format/webp/blur/1x0/quality/75|imageslim" width="66%">
    </a>
</p>

#### 创建活动场次

<p align="center">
    <a href="http://cdn.tigerb.cn/20191229161159.jpg?imageMogr2/thumbnail/1941x5453!/format/webp/blur/1x0/quality/75%7Cimageslim" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20191229161159.jpg?imageMogr2/thumbnail/1941x5453!/format/webp/blur/1x0/quality/75%7Cimageslim" width="66%">
    </a>
</p>

#### 活动列表

<p align="center">
    <a href="http://cdn.tigerb.cn/20191229161209.png?imageMogr2/thumbnail/1338x761!/format/webp/blur/1x0/quality/75%7Cimageslim" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20191229161209.png?imageMogr2/thumbnail/1338x761!/format/webp/blur/1x0/quality/75%7Cimageslim" width="66%">
    </a>
</p>


## 接口设计

1. 获取活动信息 GET {version}/glue/activity

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
serial_no|string|Y|活动编号

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "serial_no": "string, spu id",
        "name": "string, 活动名称",
        "description": "string, 活动描述",
        "start_time": "number, 活动开始时间",
        "end_time": "number, 活动开始时间",
        "times": "number, 活动抽奖次数限制，0不限制",
        "sessions_list":[
            {
                "start_time": "number, 场次开始时间",
                "end_time": "number, 场次开始时间",
                "times": "number, 场次抽奖次数限制，0不限制",
                "prizes_list": [
                    {
                        "name": "string, 奖品名称",
                        "pic_url": "string, 奖品图片"
                    }
                ]
            }
        ]
    }
}
```

2. 抽奖 POST {version}/glue/activity/draw

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
serial_no|string|Y|活动编号
uid|number|Y|用户ID

响应内容：
```json
// 中奖
{
    "code": "200",
    "msg": "OK",
    "result": {
        "serial_no": "string, spu id",
        "act_remaining_times": "number, 本活动抽奖剩余次数，0不限制",
        "session_remaining_times": "number, 本场次抽奖剩余次数，0不限制",
        "prizes_info": 
        {
            "name": "string, 奖品名称",
            "pic_url": "string, 奖品图片"
        }
    }
}

// 未中奖
{
    "code": "401",
    "msg": "",
    "result": {
        
    }
}
```