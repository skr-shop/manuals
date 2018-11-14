
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
    `path` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '分类地址',
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
    `price` decimal(11,2) unsigned NOT NULL DEFAULT '0' COMMENT '售价',
    `market_price` decimal(11,2) unsigned NOT NULL DEFAULT '0' COMMENT '市场价',
    `extends` text NOT NULL DEFAULT '0' COMMENT '扩展字段',
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
    `attrs` text COMMENT '属性{attr_id}-{attr_value_id} 多个属性逗号分隔',
    `banner_url` text COMMENT 'banner图片 多个图片逗号分隔',
    `main_url` text COMMENT '商品介绍主图 多个图片逗号分隔',
    `price` decimal(11,2) unsigned NOT NULL DEFAULT '0' COMMENT '售价',
    `market_price` decimal(11,2) unsigned NOT NULL DEFAULT '0' COMMENT '市场价',
    `extends` text NOT NULL DEFAULT '0' COMMENT '扩展字段',
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
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='sku库存表';

```