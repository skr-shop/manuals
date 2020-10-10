# 订单结算页面

<p align="center">
    <a href="http://cdn.tigerb.cn/20200331124724.jpeg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20200331124724.jpeg" width="66%">
    </a>
</p>

```

```

<p align="center">
    <a href="http://cdn.tigerb.cn/20200929124345.jpeg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20200929124345.jpeg" width="66%">
    </a>
</p>

```
```

<p align="center">
    <a href="http://cdn.tigerb.cn/20200329222214.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20200329222214.png" width="66%">
    </a>
</p>

```
```

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
is_default|int|-|-|是否是默认地址
label|string|-|-|地址类型标签，家、公司等
longitude|string|-|-|经度
latitude|string|-|-|纬度