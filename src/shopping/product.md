# 商品系统

## 商品系统(Temporal万物)

今天我们开始「商品系统」的篇章。本文分为如下五大模块：

- 需求分析
- 架构设计
- Spu和Sku的故事
- 数据模型设计
- 接口设计

第一篇我们主要看看一个入门的电商平台(**B2C**)如何去构建自己的**基础商品信息**，其实这个事情很简单，想想我们的现实生活，商家**摆放**商品到货架，客户从货架**挑选**商品，客户把挑选好的商品**放入**购物车(篮)，最后客户去收银台**结账**。

### 需求分析

对于一个电商平台来讲，我们怎么理解上面的简单示例呢？接着，我们来拆分上面这个简单的事情：

> 商家**摆放**商品到货架，客户从货架**挑选**商品，客户把挑选好的商品**放入**购物车(篮)，最后客户去收银台**结账**

1. 商家是谁：电商平台
2. 摆放是什么意思：上架
3. 货架在哪：前台系统(web/app/...)
4. 挑选：浏览前台系统
5. 放入：点击前台系统「加入购物车按钮」
6. ...(暂不多说了)

**备注**：本篇文章主要来看看1、2、3、4步该如何去设计。

通过上面的分析我们可以得出下面的信息：

1. 我们需要一个「电商平台」，电商平台里面需要有个**商品后台系统**。
2. 我们上架什么东西呢？商品！所以**商品后台系统**需要具备**创建**和**发布**商品到**前台系统**的功能。
3. 我们需要一个**前台系统**(比如网页)，前台系统具备商品列表和商品详情的页面，可供用户**浏览**。
4. 前台系统的数据怎么来？所以我们需要一个**接口网关**(对外统一提供服务能力，企业总线)和**商品服务**

整理之后得到如下的需求点：

需求点|功能点|项目命名|技术栈
-----|-----|-----|-----
商品后台系统|1.创建商品 2.发布商品到前台系统|Temporal Backend|PHP
前台系统|1.商品列表 2.商品详情| Skr Frontend|Vue
接口网关|企业总线| Skr Gateway|kong
商品服务|1.创建商品接口 2.商品状态变更接口 2.商品列表接口 3. 商品详情接口|Temporal Service|Golang

### 架构设计

通过上面的需求分析，再加上之前的《电商设计手册之用户体系》中的用户体系和《支付开发，不得不了解的国内、国际第三方支付流程》中的支付服务，我们规划出以下的架构图。

<p align="center">
    <a href="http://rmq67gta1.sabkt.gdipper.com/skr-product-service.jpg" data-lightbox="roadtrip">
        <img src="http://rmq67gta1.sabkt.gdipper.com/skr-product-service.jpg">
    </a>
</p>

### Spu和Sku的故事

对我们程序猿来讲「商品系统」刚开始的样子就是如下三点：

1. 创建商品功能：首先我们会有一张商品表，每创建一个商品我们会的到一个goods_id，如果商品存在父子的关系，加一个parent_id的字段就搞定了。
2. 商品列表接口：商品表分页查询商品。
3. 商品详情接口：商品表按goods_id索引查询商品信息。

很简单是吧，基本一张表就搞定了，看起来也是没什么问题的。但是呢，程序设计的巧妙之处就在于**抽象能力**，电商行业把`goods_id`进行了进一步的抽象，产生了Spu和Sku概念，在了解Spu和Sku定义之前，我们还得了解下**销售属性**的含义，举个例子便于理解：

想想我们的现实生活，假如我们去批发市场上了一批AJ1球鞋，批发商会给我们不同**配色**、**大小**的AJ1球鞋。我们在店里销售这些商品时都会询问客户：“您是需要什么**颜色**和**大小**的AJ1球鞋呢？”。这里的**颜色**和**大小**就是所谓的**销售属性**，因为不同**颜色**和**大小**的AJ1球鞋可能价格不同、库存数量不同，现实生活中是不是如此，不同颜色或大小的AJ1都有差别巨大的价格。

接着，我们来看看Spu和Sku定义：

名称|概念|解释
---|---|---
Spu|standard product unit 标准产品单位|goods_id剥离销售属性的部分，例如：小米8。商品列表我们展示Spu列表。
Sku|stock keeping unit 库存量单位|就是你想买的那个商品真正的编号，这个编号对应的库存就是你想买的那个商品的库存量。Spu+一或多个销售属性对应一个Sku，例如：小米8黑128G，其中黑和128G就是销售属性，小米8就是一个Spu。

搞清楚了么？

### 数据模型设计

所以最后简单的**商品表**就拆成了**spu表**和**sku表**，接着我们还抽象出来了可复用的**销售属性表**和**销售属性值表**。除此之外
我们应该还有**品牌表**、**类别表**、简单的**sku库存表**(目前简单设计此表，后期具体业务重构此表)。接着我们列下这些表的明细：

表名称|表名
---|---
品牌表|product_brands
类别表|product_category
spu表|product_spu
sku表|product_sku
销售属性表|product_attr
销售属性值|product_attr_value
sku库存表|product_sku_stock

除了上面的表之外，我又加了另一张表 `关联关系冗余表 product_spu_sku_attr_map`，为什么呢？顾名思义，冗余用的，有了这张表，我们可以很高效的得到：

1. spu下 有哪些sku
2. spu下 有那些销售属性
3. spu下 每个销售属性对应的销售属性值(一对多)
4. spu下 每个销售属性值对应的sku(一对多)

具体表结构如下所示：

```sql

-- 品牌表 product_brands
CREATE TABLE `product_brands` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '品牌ID',
    `name` varchar(255)  NOT NULL DEFAULT '' COMMENT '品牌名称',
    `desc` varchar(255)  NOT NULL DEFAULT '' COMMENT '品牌描述',
    `logo_url` varchar(255)  NOT NULL DEFAULT '' COMMENT '品牌logo图片',
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
    `name` varchar(255)  NOT NULL DEFAULT '' COMMENT '分类名称',
    `desc` varchar(255)  NOT NULL DEFAULT '' COMMENT '分类描述',
    `pic_url` varchar(255)  NOT NULL DEFAULT '' COMMENT '分类图片',
    `path` varchar(255)  NOT NULL DEFAULT '' COMMENT '分类地址{pid}-{child_id}-...',
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
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'SPU ID',
    `brand_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '品牌ID',
    `category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
    `name` varchar(255)  NOT NULL DEFAULT '' COMMENT 'spu名称',
    `desc` varchar(255)  NOT NULL DEFAULT '' COMMENT 'spu描述',
    `selling_point` varchar(255)  NOT NULL DEFAULT '' COMMENT '卖点',
    `unit` varchar(255)  NOT NULL DEFAULT '' COMMENT 'spu单位',
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
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'SKU ID',
    `spu_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'SPU ID',
    `attrs` text COMMENT '销售属性值{attr_value_id}-{attr_value_id} 多个销售属性值逗号分隔',
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

-- 销售属性表 product_attr
CREATE TABLE `product_attr` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '销售属性ID',
    `name` varchar(255)  NOT NULL DEFAULT '' COMMENT '销售属性名称',
    `desc` varchar(255)  NOT NULL DEFAULT '' COMMENT '销售属性描述',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售属性表';

-- 销售属性值 product_attr_value
CREATE TABLE `product_attr_value` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '销售属性值ID',
    `attr_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '销售属性ID',
    `value` varchar(255)  NOT NULL DEFAULT '' COMMENT '销售属性值',
    `desc` varchar(255)  NOT NULL DEFAULT '' COMMENT '销售属性值描述',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售属性值';

-- 关联关系冗余表 product_spu_sku_attr_map
-- 1. spu下 有哪些sku
-- 2. spu下 有那些销售属性
-- 3. spu下 每个销售属性对应的销售属性值(一对多)
-- 4. spu下 每个销售属性值对应的sku(一对多)
CREATE TABLE `product_spu_sku_attr_map` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `spu_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'SPU ID',
    `sku_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'SKU ID',
    `attr_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '销售属性ID',
    `attr_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '销售属性名称',
    `attr_value_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '销售属性值ID',
    `attr_value_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '销售属性值',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='关联关系冗余表';

-- sku库存表 product_sku_stock
CREATE TABLE `product_sku_stock` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `sku_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'SKU ID',
    `quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '库存',
    `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='sku库存表';

```

### 接口设计

关于接口设计目前很简单，无非列表和详情。但是这里我做了一个很好的设计**动静分离**，例如库存的动态的数据，单独提供接口，其他列表和详情数据完全静态化，把流量打到CDN去，这里又会说到我们下步计划的基础服务体系里的「静态资源服务」，这个服务的主要功能就是把我们的接口数据静态化。具体的**V1.0**版的接口设计如下：

1、spu详情 GET {version}/product/spu/{spu_id}

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
            "selling_point": "string, 卖点",
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
            "attrs": [ // 有那些销售属性
                {
                    "id": "销售属性ID",
                    "name": "string, 销售属性名称",
                    "desc": "string, 销售属性描述",
                    "values": [ // 每个销售属性对应的销售属性值(一对多)
                        {
                            "id": "销售属性值ID",
                            "name": "string, 销售属性值",
                            "desc": "string, 销售属性值描述",
                            // 每个销售属性值对应的sku(一对多)
                            // 页面初始化时，按钮不可点击逻辑判断： 如果该销售属性值下所有sku没有库存，则该销售属性按钮不可点击
                            // 选择销售属性值时，按钮不可点击逻辑判断：销售属性构成双向链表，每个销售属性又是一个单向链表存改销售属性对应的所有销售属性值。每当选择一个销售属性值时先前和后一个销售属性遍历，执销售属性值下所有sku售罄的按钮不可点击，且当前销售属性值map记录key为当前点击的销售属性值ID，值统一标示一下就行，目的记录是由于选择了哪个销售属性值使得当前的销售属性值为售罄状态
                            // 取消选择销售属性值时，按钮不可点击逻辑恢复判断：数据结构同上，遍历，记录的map删除key为当前取消选中的销售属性值，并判断是否还有别的key使得该销售属性值为售罄状态，如果没有则恢复未售罄状态
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

2、获取spu下所有skus库存 GET {version}/stock/spu/{spu_id}

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

3、sku详情 GET {version}/product/sku/{sku_id}

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

4、spu列表 GET {version}/product/spu/list

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
-|-|-|-

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