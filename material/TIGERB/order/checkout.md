# 一篇文章搞清电商订单结算页面设计？

## 前言

<p align="center">
    <a href="http://cdn.tigerb.cn/20201015193036.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20201015193036.png" width="66%">
    </a>
</p>

## 订单结算页面长啥样？

某东的订单结算页面

<p align="center">
    <a href="http://cdn.tigerb.cn/20200331124724.jpeg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20200331124724.jpeg" width="66%">
    </a>
</p>

某宝的订单结算页面

<p align="center">
    <a href="http://cdn.tigerb.cn/20200929124345.jpeg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20200929124345.jpeg" width="66%">
    </a>
</p>

## 订单结算页面的组成

<p align="center">
    <a href="http://cdn.tigerb.cn/20201014203046.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20201014203046.png" width="66%">
    </a>
</p>

## 订单结算页面各模块分析

模块编号|模块名称|子模块编号|子模块名称|模块描述
------------|------------|------------|------------|------------
1|地址模块|-|-|展示用户最优地址
2|支付方式模块|-|-|该订单支持的支付方式
3|店铺模块|-|-|包含店铺信息、商品信息、参与的优惠信息、可选的物流方式、商品售后信息等
3|-|3.1|店铺信息模块|-
3|-|3.2|商品信息模块|-
3|-|3.3|物流模块|可选择的配送方式
3|-|3.4|售后模块|商品享有的售后权益信息
3|-|3.5|优惠模块|可选择的销售活动优惠选项
3|-|3.6|店铺商品金额信息模块|-
4|发票模块|-|-|选择开发票的类型、补充发票信息
5|优惠券模块|-|-|展示该订单可以使用的优惠券列表
6|礼品卡模块|-|-|展示可以选择使用礼品卡列表
7|订单金额信息模块|-|-|包含该订单的金额明细

## 地址模块

> 展示用户的最优地址

最优地址逻辑：

- 首先，用户设置的默认地址
- 如果没有默认地址，则返回最近下单的地址

字段名称|类型|下级字段名称|类型|字段含义
------|------|------|------|------
consignee|string|-|-|收货人姓名
email|string|-|-|收货人邮箱(返回值用户名部分打码)
mobile|string|-|-|收货人手机号(返回值中间四位打码)
country|object|id|int64|国家ID
country|pbject|name|string|国家名称
province|object|id|int64|省ID
province|pbject|name|string|省名称
city|object|id|int64|市ID
city|pbject|name|string|市名称
county|object|id|int64|区县ID
county|pbject|name|string|区县名称
street|object|id|int64|街道乡镇ID
street|pbject|name|string|街道乡镇名称
detailed_address|string|-|-|详细地址(用户手填)
postal_code|string|-|-|邮编
address_id|int64|-|-|地址ID
is_default|bool|-|-|是否是默认地址
label|string|-|-|地址类型标签，家、公司等
longitude|string|-|-|经度
latitude|string|-|-|纬度

<p align="center">
    <a href="http://cdn.tigerb.cn/20201010203421.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20201010203421.png" width="100%">
    </a>
</p>

模块数据demo：
```json
{
    "address_module": {
        "consignee": "收货人姓名",
        "email": "收货人邮箱(返回值用户名部分打码)",
        "mobile": "收货人手机号(返回值中间四位打码)",
        "country": {
            "id": 666,
            "name": "国家名称"
        },
        "province": {
            "id": 12123,
            "name": "省名称"
        },
        "city": {
            "id": 212333,
            "name": "市名称"
        },
        "county": {
            "id": 1233222,
            "name": "区县名称"
        },
        "street": {
            "id": 9989999,
            "name": "街道乡镇名称"
        },
        "detailed_address": "详细地址(用户手填)",
        "postal_code": "邮编",
        "address_id": 212399999393,
        "is_default": false,
        "label": "地址类型标签，家、公司等",
        "longitude": "经度",
        "latitude": "纬度"
    }
}
```

## 支付方式模块

> 该订单支持的支付方式

支付方式选项：

- 在线支付
- 货到付款

字段名称|类型|下级字段名称|类型|字段含义
------|------|------|------|------
pay_method_list|array|id|int|支付方式ID
pay_method_list|array|name|string|支付方式名称
pay_method_list|array|desc|string|支付方式描述


<p align="center">
    <a href="http://cdn.tigerb.cn/20201010203818.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20201010203818.png" width="100%">
    </a>
</p>

模块数据demo：
```json
{
    "pay_method_module": {
        "list": [
            {
                "id": 1,
                "name": "在线支付",
                "desc": "在线支付的描述"
            },
            {
                "id": 2,
                "name": "货到付款",
                "desc": "货到付款的描述"
            }
        ]
    }   
}
```

## 店铺模块

> 包含店铺信息、商品信息、参与的优惠信息、可选的物流方式、商品售后信息等

店铺模块由如下子模块组成：

- 商品模块
    + 商品基础信息模块
    + 商品优惠信息模块
    + 售后模块
- 商品物流模块
- 店铺商品总金额信息模块

<p align="center">
    <a href="http://cdn.tigerb.cn/20201014203138.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20201014203138.png" width="36%">
    </a>
</p>

## 发票模块

> 用户选择开发票的类型以及补充发票信息

选择开发票的类型：

- 个人
- 单位

字段名称|类型|下级字段名称|类型|字段含义
------|------|------|------|------
type_id|int|-|-|发票类型,个人；单位
type_name|string|-|-|发票类型名称
type_desc|string|-|-|发票类型描述


<p align="center">
    <a href="http://cdn.tigerb.cn/20201015195856.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20201015195856.png" width="100%">
    </a>
</p>

模块数据demo：
```json
{
    "invoice_module": {
        "type_list": [
            {
                "type_id": 1,
                "type_name": "个人",
                "type_desc": "描述"
            },
            {
                "type_id": 2,
                "type_name": "公司",
                "type_desc": "描述"
            }
        ]
    }
}
```

## 优惠券模块

> 返回该订单可以使用的优惠券列表，以及默认选择对于当前订单而言的最优优惠券

## 礼品卡模块

> 展示可以选择使用礼品卡列表


字段名称|类型|下级字段名称|类型|字段含义
------|------|------|------|------
gift_card_list|array|id|int64|礼品卡id
gift_card_list|array|name|string|礼品卡名称
gift_card_list|array|desc|string|礼品卡描述
gift_card_list|array|pic_url|string|礼品卡图片
gift_card_list|array|total_amount|float64|礼品卡初始总金额
gift_card_list|array|total_amount_txt|string|礼品卡初始总金额-格式化后
gift_card_list|array|remaining_amount|float64|礼品卡剩余金额
gift_card_list|array|remaining_amount_txt|string|礼品卡剩余金额-格式化后


<p align="center">
    <a href="http://cdn.tigerb.cn/20201015200044.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20201015200044.png" width="100%">
    </a>
</p>

模块数据demo：
```json
{
    "giftcard_module": {
        "list": [
            {
                "id": 341313121,
                "name": "礼品卡名称",
                "desc": "礼品卡描述",
                "pic_url": "礼品卡图片",
                "total_amount": 100.00,
                "total_amount_txt": "100.00",
                "remaining_amount": 21.00,
                "remaining_amount_txt": "21.00"
            }
        ]
    }
}
```

## 平台积分模块

> 

比如某东叫京豆

字段名称|类型|下级字段名称|类型|字段含义
------|------|------|------|------
order_amount_min|float64|-|-|可使用积分抵现功能的订单金额下限
total_points|int64|-|-|用户总积分
can_use_points|int64|-|-|可使用的积分(可能存在冻结的积分)
points2money_rate|int|-|-|积分转换为现金比率，比如每100积分抵1元，最低1积分抵0.01元
points2money_min|int|-|-|用户最少满多少积分才可使用积分抵现
points2money_max|int|-|-|单笔订单 最多可以使用积分的上限
points_amount|float64|-|-|该订单积分可抵扣金额
points_amount_txt|string|-|-|该订单积分可抵扣金额-格式化后


<p align="center">
    <a href="http://cdn.tigerb.cn/20201015193559.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20201015193559.png" width="100%">
    </a>
</p>

模块数据demo：
```json
{
    "points_module": {
        "order_amount_min": 100.00,
        "total_points": 9999,
        "can_use_points": 9999,
        "points2money_rate": 100,
        "points2money_min": 1000,
        "points2money_max": 9999,
        "points_amount": 99.99,
        "points_amount_txt": "99.99"
    }
}
```

## 订单金额信息模块

> 包含该订单的金额明细

字段名称|类型|下级字段名称|类型|字段含义
------|------|------|------|------
skus_amount|float64|-|-|商品的总金额
promotion_amount|float64|-|-|优惠的总金额
freight|float64|-|-|运费
final_amount|float64|-|-|支付金额
promotion_detail|object|coupon_amount|float64|优惠券优惠金额
promotion_detail|object|sales_activity_amount|float64|销售活动优惠金额
promotion_detail|object|gift_cart_amount|float64|礼品卡使用金额
promotion_detail|object|points_amount|float64|该订单积分抵扣金额

```
_txt字段略
```

<p align="center">
    <a href="http://cdn.tigerb.cn/20201015200913.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20201015200913.png" width="100%">
    </a>
</p>

模块数据demo：
```json

```