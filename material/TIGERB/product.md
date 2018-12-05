
# 商品数据模型 

```sql

-- 品牌表 product_brands
CREATE TABLE `product_brands` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '品牌ID',
    `name` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '品牌名称',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '品牌描述',
    `logo_url` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '品牌logo图片',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='品牌表';

-- 类别表 product_category
CREATE TABLE `product_category` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
    `name` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '分类名称',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '分类描述',
    `pic_url` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '分类图片',
    `path` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '分类地址{pid}-{child_id}-...',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='类别表';

-- spu表 product_spu
-- spu: standard product unit 标准产品单位
CREATE TABLE `product_spu` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'spu id',
    `brand_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '品牌ID',
    `category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
    `name` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT 'spu名称',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT 'spu描述',
    `unit` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT 'spu单位',
    `banner_url` text COMMENT 'banner图片 多个图片逗号分隔',
    `main_url` text COMMENT '商品介绍主图 多个图片逗号分隔',
    `price_fee` int unsigned NOT NULL DEFAULT 0 COMMENT '售价，整数方式保存',
    `price_scale` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '售价，金额对应的小数位数',
    `market_price_fee` int unsigned NOT NULL DEFAULT 0 COMMENT '市场价，整数方式保存',
    `market_price_scale` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '市场价，金额对应的小数位数',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT AUTO_INCREMENT=666666 CHARSET=utf8mb4 COMMENT='spu表';

-- sku表 product_sku
-- sku: stock keeping unit 库存量单位
CREATE TABLE `product_sku` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'sku id',
    `spu_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'spu id',
    `attrs` text COMMENT '属性值{attr_value_id}-{attr_value_id} 多个属性值逗号分隔',
    `banner_url` text COMMENT 'banner图片 多个图片逗号分隔',
    `main_url` text COMMENT '商品介绍主图 多个图片逗号分隔',
    `price_fee` int unsigned NOT NULL DEFAULT 0 COMMENT '售价，整数方式保存',
    `price_scale` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '售价，金额对应的小数位数',
    `market_price_fee` int unsigned NOT NULL DEFAULT 0 COMMENT '市场价，整数方式保存',
    `market_price_scale` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '市场价，金额对应的小数位数',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT AUTO_INCREMENT=666666 CHARSET=utf8mb4 COMMENT='sku表';

-- 属性表 product_attr
CREATE TABLE `product_attr` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性ID',
    `name` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '属性名称',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '属性描述',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='属性表';

-- 属性值 product_attr_value
CREATE TABLE `product_attr_value` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性值ID',
    `attr_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '属性ID',
    `value` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '属性值',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '属性值描述',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='属性值';

-- 关联关系冗余表 product_spu_sku_attr_map
-- 1. spu下 有哪些sku
-- 2. spu下 有那些属性 
-- 3. spu下 每个属性对应的属性值(一对多) 
-- 4. spu下 每个属性值对应的sku(一对多)
CREATE TABLE `product_spu_sku_attr_map` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `spu_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'spu id',
    `sku_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'sku id',
    `attr_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '属性ID',
    `attr_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '属性名称',
    `attr_value_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '属性值ID',
    `attr_value_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '属性值',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='关联关系冗余表';

-- sku库存表 product_sku_stock
CREATE TABLE `product_sku_stock` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性ID',
    `sku_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'sku id',
    `quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '库存',
    `quantity_lock` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '锁定库存',
    `quantity_over` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '超卖库存 0:严格不准超卖',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='sku库存表';

```

```
仓储 --(incre sku quantity)push/pull--> update `product_sku_stock` & incr redis

回写脚本 ----> select `product_sku_stock`.`quantity`  & update
```

# API

1. spu详情 GET {version}/product/spu/{spu_id}

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
spu_id|number|yes|spu ID

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "brand_info": {
            "id": "number, 品牌ID",
            "name": "string, 品牌名称",
            "desc": "string, 品牌描述",
            "logo_url": "string, 品牌logo图片",
        },
        "category_info": {
            "id": "number, 分类ID",
            "name": "string, 品牌名称",
            "desc": "string, 品牌描述",
            "pic_url": "string, 分类图片",
            "path": "string, 分类地址{pid}-{child_id}-...",
        },
        "spu_info": {
            "id": "number, spu id",
            "name": "string, spu名称",
            "desc": "string, spu描述",
            "unit": "string, spu单位",
            "banner_url": [
                "string, banner 图片url",
                "string, banner 图片url",
            ],
            "main_url": [
                "string, 商品介绍主图 图片url",
                "string, 商品介绍主图 图片url",
            ],
            "price": "string, 售价",
            "market_price": "string, 市场价",
            "attrs": [ // 有那些属性
                { 
                    "id": "属性ID",
                    "name": "string, 属性名称",
                    "desc": "string, 属性描述",
                    "values": [ // 每个属性对应的属性值(一对多) 
                        {
                            "id": "属性值ID",
                            "name": "string, 属性值",
                            "desc": "string, 属性值描述",
                            // 每个属性值对应的sku(一对多) 
                            // 页面初始化时，按钮不可点击逻辑判断： 如果该属性值下所有sku没有库存，则该属性按钮不可点击
                            // 选择属性值时，按钮不可点击逻辑判断：???
                            "skus": [
                                "number, sku id",
                                "number, sku id",
                            ],
                        }
                    ],
                }
            ],
            "skus": [ // 有哪些sku
                "number, sku id",
                "number, sku id",
            ],
            "skus_map": {
                "{attr_value_id}-{attr_value_id}-...": "number, sku id",
                "{attr_value_id}-{attr_value_id}-...": "number, sku id",
                "{attr_value_id}-{attr_value_id}-...": "number, sku id",
                "{attr_value_id}-{attr_value_id}-...": "number, sku id",
                "{attr_value_id}-{attr_value_id}-...": "number, sku id",
                "{attr_value_id}-{attr_value_id}-...": "number, sku id",
            }
        }
    }
}
```

2. 获取spu下所有skus库存 GET {version}/stock/spu/{spu_id}

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
spu_id|number|yes|spu ID

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
            "skus_stock": {
                "int, sku id": {
                    "quantity": "int, 剩余库存数量"
                }
            }
        }
    }
}
```

3. sku详情 GET {version}/product/sku/{sku_id}

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
sku|number|yes|sku ID

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "id": "number, sku id",
        "name": "string, sku名称",
        "desc": "string, sku描述",
        "unit": "string, sku单位",
        "banner_url": [
            "string, banner 图片url",
            "string, banner 图片url",
        ],
        "main_url": [
            "string, 商品介绍主图 图片url",
            "string, 商品介绍主图 图片url",
        ],
        "price": "string, 售价",
        "market_price": "string, 市场价",
    }
}
```

4. spu列表 GET {version}/product/spu/list

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "list": [
            {
                "id": "number, spu id",
                "name": "string, spu名称",
                "desc": "string, spu描述",
                "unit": "string, spu单位",
                "banner_url": [
                    "string, banner 图片url",
                    "string, banner 图片url",
                ],
                "price": "string, 售价",
                "market_price": "string, 市场价",
            }
        ]
    }
}
```
