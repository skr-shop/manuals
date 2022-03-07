## 前言

截止目前为止SkrShop《电商设计手册》系列梳理的内容已经涵盖了如下几大块：

- 用户
- 商品
- 购物车
- 营销
- 支付
- 基础服务

今天我们准备开启一个新的篇章**订单中心**。

<p align="center">
    <a href="https://cdn.tigerb.cn/20201026131854.jpg" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201026131854.jpg" width="100%">
    </a>
</p>

订单中心系列主要内容如下：

|知识点|
|-------|
|订单结算页|
|创建订单|
|订单履约|
|订单状态|
|订单详情|
|订单逆向操作|
|...|

首先，我们来回顾下用户平常在电商平台上的购物的一个简单过程，如下图所示：

<p align="center">
    <a href="https://cdn.tigerb.cn/20201015193036.png" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201015193036.png" width="80%">
    </a>
</p>

> 所以，今天我们来聊聊什么呢？

```
答：今天的这篇文章我们主要就来聊聊上面流程中『订单结算页』的设计与实现。
```


## 订单结算页长啥样？

我们来看看某东的订单结算页面：

<p align="center">
    <a href="https://cdn.tigerb.cn/20200331124724.jpeg" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20200331124724.jpeg" width="36%">
    </a>
</p>

再来看看某宝的订单结算页面：

<p align="center">
    <a href="https://cdn.tigerb.cn/20200929124345.jpeg" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20200929124345.jpeg" width="36%">
    </a>
</p>

通过上面的截图，我们可以大致得出**订单结算页面**的主要页面内容：

- 用户默认收货地址信息
- 支付方式选择
- 店铺&商品信息
- 商品可选择的配送方式
- 发票类型选择
- 优惠信息
- 订单相关金额
- 等等

## 订单结算页面的组成

> 我一直在思考前端可以模块化，后端接口数据不可以模块化吗？

```
我的答案：是可以的。
```

我们依据上面整理的内容，再通过以往的经验把**订单结算页面**进行模块化拆分和组合，得到如下订单结算页面的**模块化构成**:

<p align="center">
    <a href="https://cdn.tigerb.cn/20201026165711.png" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201026165711.png" width="38%">
    </a>
</p>

关于这块代码如何设计，可以参考我的文章[《代码组件 | 我的代码没有else》](http://tigerb.cn/go-patterns/#/?id=%e7%bb%84%e5%90%88%e6%a8%a1%e5%bc%8f)

## 订单结算页面各模块分析

模块编号|模块名称|子模块编号|子模块名称|模块描述
------------|------------|------------|------------|------------
1|地址模块|-|-|展示用户最优地址
2|支付方式模块|-|-|该订单支持的支付方式
3|店铺模块|-|-|包含店铺信息、商品信息、参与的优惠信息、可选的物流方式、商品售后信息等
3|-|3.1|商品模块|包含子模块：商品基础信息模块、商品优惠信息模块、售后模块
3|-|3.2.1|商品基础信息模块|商品的信息，名称、图片、价格、库存等
3|-|3.2.2|商品优惠信息模块|选择的销售活动优惠选项
3|-|3.2.3|售后模块|商品享有的售后权益信息
3|-|3.3|物流模块|可选择的配送方式
3|-|3.4|店铺商品金额信息模块|-
4|发票模块|-|-|选择开发票的类型、补充发票信息
5|优惠券模块|-|-|展示该订单可以使用的优惠券列表
6|礼品卡模块|-|-|展示可以选择使用礼品卡列表
7|平台积分模块|-|-|用户可以使用积分抵掉部分现金
8|订单金额信息模块|-|-|包含该订单的金额明细

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
country|object|name|string|国家名称
province|object|id|int64|省ID
province|object|name|string|省名称
city|object|id|int64|市ID
city|object|name|string|市名称
county|object|id|int64|区县ID
county|object|name|string|区县名称
street|object|id|int64|街道乡镇ID
street|object|name|string|街道乡镇名称
detailed_address|string|-|-|详细地址(用户手填)
postal_code|string|-|-|邮编
address_id|int64|-|-|地址ID
is_default|bool|-|-|是否是默认地址
label|string|-|-|地址类型标签，家、公司等
longitude|string|-|-|经度
latitude|string|-|-|纬度

<p align="center">
    <a href="https://cdn.tigerb.cn/20201010203421.png" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201010203421.png" width="100%">
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
    <a href="https://cdn.tigerb.cn/20201010203818.png" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201010203818.png" width="100%">
    </a>
</p>

模块数据demo：
```json
{
    "pay_method_module": {
        "pay_method_list": [
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
    <a href="https://cdn.tigerb.cn/20201014203138.png" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201014203138.png" width="36%">
    </a>
</p>

由于此处内容比较多我们之后再来单独分析。

## 发票模块

> 用户选择开发票的类型以及补充发票信息

选择开发票的类型：

- 个人
- 单位

字段名称|类型|下级字段名称|类型|字段含义
------|------|------|------|------
type_id|int|-|-|发票类型：个人；单位
type_name|string|-|-|发票类型名称
type_desc|string|-|-|发票类型描述


<p align="center">
    <a href="https://cdn.tigerb.cn/20201015195856.png" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201015195856.png" width="100%">
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

- 展示用户的优惠券列表：当前订单可用的排最前面其他放最后面
- 默认选中最优优惠券：对于当前订单优惠力度最大的一张优惠券

关于优惠券的其他内容可以阅读优惠券章节内容。

## 礼品卡模块

> 展示可以选择使用礼品卡列表

字段名称|类型|下级字段名称|类型|字段含义
------|------|------|------|------
giftcard_list|array|id|int64|礼品卡id
giftcard_list|array|name|string|礼品卡名称
giftcard_list|array|desc|string|礼品卡描述
giftcard_list|array|pic_url|string|礼品卡图片
giftcard_list|array|total_amount|float64|礼品卡初始总金额
giftcard_list|array|total_amount_txt|string|礼品卡初始总金额-格式化后
giftcard_list|array|remaining_amount|float64|礼品卡剩余金额
giftcard_list|array|remaining_amount_txt|string|礼品卡剩余金额-格式化后


<p align="center">
    <a href="https://cdn.tigerb.cn/20201026165855.png" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201026165855.png" width="100%">
    </a>
</p>

模块数据demo：
```json
{
    "giftcard_module": {
        "giftcard_list": [
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

> 用户可以使用积分抵现

比如上线某东订单结算页面中的京豆。

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
    <a href="https://cdn.tigerb.cn/20201015193559.png" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201015193559.png" width="100%">
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
promotion_detail|object|giftcard_amount|float64|礼品卡使用金额
promotion_detail|object|points_amount|float64|该订单积分抵扣金额

```
_txt字段略
```

<p align="center">
    <a href="https://cdn.tigerb.cn/20201015200913.png" data-lightbox="roadtrip">
        <img src="https://cdn.tigerb.cn/20201015200913.png" width="100%">
    </a>
</p>

模块数据demo：
```json
{
    "order_amount_module": {
        "skus_amount": 99.99,
        "skus_amount_txt": "99.99",
        "promotion_amount_total": 10.00,
        "promotion_amount_total_txt": "10.00",
        "freight_total": 8.00,
        "freight_total_txt": "8.00",
        "final_amount": 97.99,
        "final_amount_txt": "97.99",
        "promotion_detail": {
            "coupon_amount": 5.00,
            "coupon_amount_txt": "5.00",
            "sales_activity_amount": 5.00,
            "sales_activity_amount_txt": "5.00",
            "giftcard_amount": 0,
            "giftcard_activity_amount_txt": "0",
            "points_amount": 0,
            "points_amount_txt": "0"
        }
    }
}
```

## 结语

如上，订单结算页面的内容基本介绍完毕了，有任何问题随时到我们的github项目下留言 <https://github.com/skr-shop/manuals/issues>。


```
关于我的常用画图软件：

1. Balsamiq Mockups 3
2. Processon
```