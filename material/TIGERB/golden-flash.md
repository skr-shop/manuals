# Golden Flash 金色闪光

金色闪光来自火影中四代火影**波风水门**的外号，速度的代表，适合顺势高并发的场景。

# 前言

针对任何电商平台等高并发场景，比如**限量销售**、**限时销售**、**降价销售**、**抢优惠券**、**抽奖**等。

本质上是一个**和业务相关**的限流工具。

数据一致性要求并不高 且 可以容忍数据丢失

# 架构



# 交互设计

# API

1. 获取活动信息接口 GET {version}/activity/info

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
act_id|number|Y|活动ID，本次秒抢活动的ID

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "server_time": "int, 服务器时间，时间戳",
        "lists": [
            {
                "object_id": "number, 事物ID，被抢物品的ID",
                "object_name": "number, 事物ID，被抢物品的名称",
                "object_pic": [
                    "string, 被抢物品的图片",
                    "string, 被抢物品的图片",
                ],
                "start_time": "int, 开始时间，时间戳",
                "end_time": "int, 结束时间，时间戳",
                "process": "int, 进度百分比 0～100，令牌剩余数量/令牌总数",
            }
        ]
    }
}
```

2. 加入排队接口 POST {version}/queue/add

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
act_id|number|Y|活动ID，本次秒抢活动的ID
object_id|number|Y|事物ID，被抢物品的ID
user_id|number|Y|用户ID

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "interval_time": "number, 查询排队结果的轮询时间",
        "voucher": "string, 排队成功的凭证，用于获取排队结果"
    }
}
```

3. 查询排队结果的接口 GET {version}/queue/result

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
voucher|number|Y|活动ID，本次秒抢活动的ID
user_id|number|Y|用户ID

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "token": "string, 令牌，用户可以拿去此令牌去进行后续流程，比如添加抢购商品到购物车、抽奖"
    }
}
```