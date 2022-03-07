<h1 align="center">《电商设计手册 | SkrShop》</h1>

<p align="center">Do design No code | 只设计不码码</p>

<p align="center">
    <img src="https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-red" alt="Lisense">
</p>

<p align="center"><a href="http://skrshop.tech/">skrshop.tech</a></p>

<p align="center">
    <img style="vertical-align:middle" width="60%" src="https://cdn.tigerb.cn/20191222164829.jpg?imageMogr2/thumbnail/1280x720!/format/webp/blur/1x0/quality/90|imageslim">
<p>

# 版权声明
- 未经版权所有者明确授权，禁止发行本手册及其被实质上修改的版本。 
- 未经版权所有者事先授权，禁止将此作品及其衍生作品以标准（纸质）书籍形式发行。  
- 未与任何第三方以任何形式合作。

<p align="center">
    <img style="vertical-align:middle" width="25%" src="https://cdn.tigerb.cn/wechat-blog-qrcode.jpg?imageMogr2/thumbnail/260x260!/format/webp/blur/1x0/quality/90|imageslim">
    <img style="vertical-align:middle" width="45%" src="https://dayutalk.cn/img/pub-qr.jpeg">
    <i style="display:inline-block; height:100%; vertical-align:middle; width:0;"></i>
<p>

# 大厂内推

为大家提供各个大厂渠道的内推。

## 抖音电商

1. 超高速发展的业务；意味着：技术挑战大、发挥空间大、钱多！
2. 业界最新技术；微服务、ServiceMesh、Faas 都已经有落地方案，只要想，内部资料随时学；
3. 技术氛围好；每周都有技术团队分享，随时约会交流，没有部门壁垒；

欢迎将简历投递至我的邮箱：**dayugog@gmail.com**
<br>
不限年限，只要你敢投，我就敢帮你推，快上车~

## 小米海外电商

- 简介：小米网海外电商平台
- 技术栈：Go
- 挑战，期待和你一起来解决：
    + 全球化翻译问题
    + 全球多机房问题
    + 海外快速复制电商系统平台问题
    + 反黄牛

如果你对这些挑战很感兴趣，欢迎将简历投递至我的邮箱：**tigerbcode@gmail.com**
<br>
不限年限，只要你敢投，我就敢帮你推，快上车~

# Star趋势

[![Stargazers over time](https://starchart.cc/skr-shop/manuals.svg)](https://starchart.cc/skr-shop/manuals)

# 架构

<p align="center">
    <a href="https://cdn.tigerb.cn/20200628125645.jpg">
        <img src="https://cdn.tigerb.cn/20200628125645.jpg" width="100%">
    </a>
</p>

# 目录

- [前言](http://skrshop.tech/#/)
- [目录](http://skrshop.tech/#/guide)
- [技术栈选型](http://skrshop.tech/#/?id=技术栈选型)
- [代码仓库](http://skrshop.tech/#/?id=代码仓库)
- [用户体系](http://skrshop.tech/#/src/account/?id=用户体系)
    + [账户服务](http://skrshop.tech/#/src/account/?id=架构设计)
    + [权限服务](http://skrshop.tech/#/src/account/?id=后台权限管理)
- [购物体系](http://skrshop.tech/#/src/shopping/cart?id=购物体系)
    + [商品系统(Temporal万物)](http://skrshop.tech/#/src/shopping/product?id=商品系统)
    + [购物车服务](http://skrshop.tech/#/src/shopping/cart?id=购物车服务)
    + [购物车架构](http://skrshop.tech/#/src/shopping/cart?id=购物车架构)
- [营销体系](http://skrshop.tech/#/src/promotion/)
    + 活动营销系统
        * [通用抽奖工具(Glue万能胶)](http://skrshop.tech/#/src/promotion/glue)
    + 销售营销系统
    + 基础服务
        * [秒杀服务](http://skrshop.tech/#/src/promotion/seckill)
        * [优惠券服务](http://skrshop.tech/#/src/promotion/coupon)
        * 积分服务
- [交易中心](http://skrshop.tech/#/src/trade/)
    + [常见第三方支付流程](http://skrshop.tech/#/src/trade/?id=常见第三方支付流程)
    + [支付系统设计](http://skrshop.tech/#/src/trade/?id=支付系统设计)
    + 收银台
- [订单中心](http://skrshop.tech/#/src/order/)
    + [订单结算页](http://skrshop.tech/#/src/order/checkout)
- [仓储系统](http://skrshop.tech/#/src/warehouse/)
    + 地址服务
- [物流系统](http://skrshop.tech/#/src/express/)
- [售后服务](http://skrshop.tech/#/src/aftersale/)
- [基础服务](http://skrshop.tech/#/src/base/)
    + 接口静态化服务
    + 上传服务
    + 消息服务
        * 短信
        * 邮件
        * 微信模板消息
        * 站内信

# 前言

一直从事互联网电商开发三年多的时间了，回头想想却对整个业务流程不是很了解，说出去很是惭愧。但是身处互联网电商的环境中，或多或少接触了其中的各个业务，其次周边还有很多从事电商的同事和朋友，这都是资源。于是，我决定和我的同事、盆友们、甚至还有你们去梳理整个流程并分享出来，谈不上结果要做的多么好，至少在每一个我们有能力去做好的地方，一定会细致入微。

除此之外，同时为了满足我们自身在工作中可能得不到的技术满足感，我们在做整个系统设计的过程中，会去使用我们最想用的技术栈。技术栈这一点我们借助docker去实现，所以最终的结果：一方面我们掌握了业务的东西，另一方面又得到了技术上的满足感，二者兼得。

最后，出于时间的考虑，我们提出了一个想法**Do design No code**。**【只设计不码码】** 这句话的意思：最终我们设计出来整个系统的数据模型，接口文档，甚至交互过程，以及环境部署等，但是最后我们却不写代码。是吧？如果这样了写代码还有什么意义。当然，也不全是这样，出于时间的考虑当然也会用代码实现出来的，说不定最后正是对面的你去实现的。

其次，这些内容肯定有考虑不全面或者在上规模的业务中存在更复杂的地方，欢迎指出，我们也希望学习和分享您的经验。

# 技术栈选型

```
- 基础环境
    + k8s
    + docker
- 存储
    + mysql
    + redis
        * codis
        * redis主从
- queue
    + kafka
    + rocketmq
    + rabbitmq
- gw
    + kong
    + zuul
- webserver
    + nginx/openresty
    + envoy
- server
    + go
    + php
- frontend
    + vue
- rpc
    + grpc
    + thrift
- 基础能力
    + 监控
        * zipkin
        * elk
        * falcon
    + 服务发现
        * zookeeper
        * etcd
    + 持续集成
        * ci/cd
- 搜索
    + es
    + solr
```

# 代码仓库

请您耐心等待...

# Skr Shop项目成员简介

排名不分先后，字典序

昵称|简介|个人博客
--------|--------|--------
AStraw|研究生创业者|公众号“稻草人生”
大愚Dayu|国内大多人使用的PHP第三方支付聚合项目[Payment](https://github.com/helei112g/payment)作者，创过业|[大愚Talk](http://dayutalk.cn/)
lwhcv|曾就职于百度/融360|--------
TIGERB|PHP框架[EasyPHP](http://easy-php.tigerb.cn/#/)作者| [TIGERB的技术博客](http://tigerb.cn)
Veaer|宇宙无敌风火轮全干工程师| [Veaer](http://veaer.com)
