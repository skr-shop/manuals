<h1 align="center">《电商设计手册》</h1>

<p align="center">Do design No code | 只设计不码码</p>

<p align="center">
    <img src="https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-red" alt="Lisense">
</p>

<p align="center"><a href="http://skrshop.tech/">skrshop.tech</a></p>

# 版权申明
- 未经版权所有者明确授权，禁止发行本手册及其被实质上修改的版本。 
- 未经版权所有者事先授权，禁止将此作品及其衍生作品以标准（纸质）书籍形式发行。  

<div style="text-align:center">
           <img style="vertical-align:middle" width="30%" src="http://cdn.tigerb.cn/wechat-blog-qrcode.jpg?imageMogr2/thumbnail/260x260!/format/webp/blur/1x0/quality/90|imageslim">
           <img style="vertical-align:middle" width="30%" src="https://mmbiz.qpic.cn/mmbiz_jpg/zm9WZ2XoW58eUJSu7oOriaP2JSDt0QPR6HiaMgkKcYaqSfUibibiaPwf59ia1TtwxRttMOAbdt34seOLQWILZCPibx8WQ/0?wx_fmt=jpeg">
           <i style="display:inline-block; height:100%; vertical-align:middle; width:0;"></i>
<div>

## Stargazers over time

[![Stargazers over time](https://starchart.cc/skr-shop/manuals.svg)](https://starchart.cc/skr-shop/manuals)

# 目录

- [前言](?id=前言)
- [技术栈选型](?id=技术栈选型)
- [代码仓库](?id=代码仓库)
- [用户体系](?id=用户体系)
    + [账户服务](?id=用户体系)
    + [权限服务](?id=用户体系)
- [购物体系](?id=购物体系)
    + [商品系统(Temporal万物)](?id=商品系统)
    + 购物车服务
    + 订单生成服务
- [营销体系](?id=营销体系)
    + 活动营销系统
        * 通用抽奖工具(Glue万能胶)
    + 销售营销系统(满减/买送/加价购/限时购...)
    + 基础服务
        * 优惠券服务
        * 积分服务
- [交易中心](?id=交易中心)
    + [常见第三方支付流程](?id=常见第三方支付流程)
    + [支付系统设计](?id=支付系统设计)
    + 收银台
- [订单中心](?id=订单中心)
- [仓储系统](?id=仓储系统)
    + 地址服务
- [物流系统](?id=物流系统)
- [售后服务](?id=售后服务)
- [基础服务](?id=基础服务)
    + 秒抢工具(Gloden-Flash金色闪光)

# 前言

一直从事互联网电商开发三年多的时间了，回头想想却对整个业务流程不是很了解，说出去很是惭愧。但是身处互联网电商的环境中，或多或少接触了其中的各个业务，其次周边还有很多从事电商的同事和朋友，这都是资源。于是，我决定和我的同事、盆友们、甚至还有你们去梳理整个流程并分享出来，谈不上结果要做的多么好，至少在每一个我们有能力去做好的地方，一定会细致入微。

除此之外，同时为了满足我们自身在工作中可能得不到的技术满足感，我们在做整个系统设计的过程中，会去使用我们最想用的技术栈。技术栈这一点我们借助docker去实现，所以最终的结果：一方面我们掌握了业务的东西，另一方面又得到了技术上的满足感，二者兼得。

最后，出于时间的考虑，我们提出了一个想法**Do design No code**。**【只设计不码码】**这句话的意思：最终我们设计出来整个系统的数据模型，接口文档，甚至交互过程，以及环境部署等，但是最后我们却不写代码。是吧？如果这样了写代码还有什么意义。当然，也不全是这样，出于时间的考虑当然也会用代码实现出来的，说不定最后正是对面的你去实现的。

其次，这些内容肯定有考虑不全面或者在上规模的业务中存在更复杂的地方，欢迎指出，我们也希望学习和分享您的经验。

##### skrshop项目成员简介

排名不分先后，字典序

昵称|简介|个人博客
--------|--------|--------
AStraw|研究生创业者, 现于小米科技海外商城组从事商城后端研发工作|--------
大愚Dayu|国内大多人使用的PHP第三方支付聚合项目[Payment](https://github.com/helei112g/payment)作者，创过业，现于小米科技海外商城组从事商城后端研发工作|[大愚Talk](http://dayutalk.cn/)
lwhcv|曾就职于百度/融360, 现于小米科技海外商城组从事商城后端研发工作|--------
TIGERB|PHP框架[EasyPHP](http://easy-php.tigerb.cn/#/)作者，拥有A/B/C轮电商创业公司工作经验，现于小米科技海外商城组从事商城后端研发工作| [TIGERB的技术博客](http://tigerb.cn)
Veaer|宇宙无敌风火轮全栈工程师 现于小米科技海外商城组从事商城后端研发工作| [Veaer](https://github.com/Veaer)
Faaaar|啥都不会, 凑热闹的菜逼|[Faaaar](https://faaaar.github.io)

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
# 用户体系

今天，我们开始第一部分**用户体系**的设计。本文分为如下四大模块：

- 架构设计
- 数据模型设计
- 交互设计
- 接口设计

## 架构设计

### 简单来看用户体系

当你第一次接触和用户相关的互联网产品时，或者曾今在我眼里。**用户体系**无非就是“登录”和“注册”，“修改用户信息”这些，等。简单来做的话，无非我们需要一张表去记录用户的身份信息：注册时(insert操作)，往表里插入一个数据；登录时(select&update操作)，通过用户标识(手机号、邮箱等)判断用户的密码是否正确；修改用户信息(select&update操作)，就是直接update这个uid的用户信息(头像、昵称等)。

<p align="center">
    <a href="http://cdn.tigerb.cn/skr-account-smaple-structure.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-smaple-structure.png">
    </a>
</p>

这样设计的确没什么问题，很简单不是么。但是随着业务的发展，一方面我们需要提供统一的用户管理(高内聚)，又要提高系统的可扩展性，所以我想呈现出来的是我理解的**一个基本用户体系应该有的东西**。

### 一个基本用户体系应该有的东西

首先我们对原有的用户表进行再一次的抽象(抽离用户注册、登录依赖的字段、第三方登录) -> **账户表**，为什么这么做？随着业务的发展，以前只维护一个产品，也许某一天又开发新的产品，这样我们就可以统一的维护我们公司所有产品的注册登录逻辑，不同的产品只维护该产品和用户相关的信息即可(具体依赖产品形态)。如下图所示：

<p align="center">
    <a href="http://cdn.tigerb.cn/skr-user-system-2.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-user-system-2.png">
    </a>
</p>

上图中，还提到了第三方登录/员工表/后台权限管理，这些都是一些用户体系基本必备的结构。

第三方登录：第三方也是登录方式的一种，我们也把它抽象到账户的一部分，如上图所示。其次，关于第三方登录这里存在一个交互方式设计存在的问题，后面交互设计时会提到。

员工：因为上面我们抽离了账户表，所以内部的管理系统后台也可以统一的使用账户表的登录逻辑，这样全公司在账号这个事情上达到了真正的高内聚。

提到了员工，我们的内部各种系统后台肯定涉及各种的权限管理，所以这里提到了简单的RBAC(基于角色的权限控制)，具体的逻辑数据模型设计会提到。

### 最终的架构

随着业务产品形态的越来越复杂，在设计架构的时候，我们需要分析其中的**变与不变**：

- 变：越来越多的产品个性化用户需求
- 不变：注册登录的逻辑

最终的结果，我们把原有的用户拆成了**账户**和**用户**，同时我们也要在这里明确这两个概念的区别：

- 账户：整个体系唯一生产uid的地方，内聚注册登录逻辑，不涉及产品业务需求
- 用户：不同产品个性化的用户需求信息

最终的架构图如下：

- 第一部分：账户(**服务层**)
- 第二部分：用户(**应用层**，无限水平扩展)
- 第三部分：员工(**应用层**，员工权限体系)

<p align="center">
    <a href="http://cdn.tigerb.cn/skr-account-structure.jpg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-structure.jpg">
    </a>
</p>


## 数据模型设计

对应上面的架构，我们很容易设计出我们的数据模型(这里假设我们目前只有一个对C端的应用)：

```
账户 -> 1.账户表
用户 -> 2.用户表
员工 -> 3.员工表
```

除了上面三张表外，还需要我们的R(role)B(base)A(access)C(control)权限管理,RBAC基于角色的权限管理大家应该很熟悉，这里我就不详细说了，简单的RBAC首先需要：

```
4.系统菜单表(菜单即权限)，系统的uri路径
5.权限表(菜单即权限)，具体的权限就是访问系统的菜单
6.角色表，一个角色具有哪些权限
7.员工和角色的关联表，一个员工属于哪个角色
```

好了一个简单的RBAC涉及的表基本罗列出来了，但是在我的工作经历中大家实现的权限管理往往只针对某个系统，这样对于众多的系统后台来说就是乱、重复造轮子、权限管理效率低。所以我在上面的架构设计中把权限作为了一个服务为全系统提供基础服务能力。而达到这个目的的结果我只需要再增加一张表：

```
8.后台管理系统表, 登记所有的后台管理系统(这样通过系统id和系统资源uri的id就可以全局构成唯一性，单纯的uri存在重复的可能性，用uri不用url的原因是域名存在变动的可能性)
```

最后我们的用户体系应该基本就上面8张表。咦，貌似漏掉了第三方登录，我们加上吧，很简单如下：

```
9. 第三方用户登录表，记录不同第三方的用户标示
```

最最后就是上面的9张表了，具体的表结构和sql如下：

<p align="center">
    <a href="http://cdn.tigerb.cn/skr-account-model.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-model-2.png">
    </a>
</p>


### 表sql

**账户模型**

```sql

-- 账户模型
CREATE TABLE `account_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号id',
  `email` varchar(30) NOT NULL DEFAULT '' COMMENT '邮箱',
  `phone` varchar(15) NOT NULL DEFAULT '' COMMENT '手机号',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `create_ip_at` varchar(12) NOT NULL DEFAULT '' COMMENT '创建ip',
  `last_login_at` int(11) NOT NULL DEFAULT '0' COMMENT '最后一次登录时间',
  `last_login_ip_at` varchar(12) NOT NULL DEFAULT '' COMMENT '最后一次登录ip',
  `login_times` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
  PRIMARY KEY (`id`),
  KEY `idx_email` (`email`),
  KEY `idx_phone` (`phone`),
  KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='账户';

-- 第三方账户
CREATE TABLE `account_platform` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '账号id',
  `platform_id` varchar(60) NOT NULL DEFAULT '' COMMENT '平台id',
  `platform_token` varchar(60) NOT NULL DEFAULT '' COMMENT '平台access_token',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '平台类型 0:未知,1:facebook,2:google,3:wechat,4:qq,5:weibo,6:twitter',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_at` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`),
  KEY `idx_platform_id` (`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='第三方用户信息';
```

**用户模型**

```sql

-- 用户模型
CREATE TABLE `skr_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '账号id',
  `nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像(相对路径)',
  `gender` enum('male','female','unknow') NOT NULL DEFAULT 'unknow' COMMENT '性别',
  `role` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '角色 0:普通用户 1:vip',
  `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_at` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='账户信息';
```

**员工模型**

```sql

-- 员工表
CREATE TABLE `staff_info` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '员工id',
    `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '账号id',
    `email` varchar(30) NOT NULL DEFAULT '' COMMENT '员工邮箱',
    `phone` varchar(15) NOT NULL DEFAULT '' COMMENT '员工手机号',
    `name` varchar(30) NOT NULL DEFAULT '' COMMENT '员工姓名',
    `nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '员工昵称',
    `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '员工头像(相对路径)',
    `gender` enum('male','female','unknow') NOT NULL DEFAULT 'unknow' COMMENT '员工性别',
    `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
    `update_at` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_uid` (`uid`),
    KEY `idx_email` (`email`),
    KEY `idx_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工信息(这里列了大概的信息，多的可以垂直拆表)';

```

**系统权限管理模型**

```sql

-- 权限管理: 系统map
CREATE TABLE `auth_ms` (
    `id` smallint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `ms_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '系统名称',
    `ms_desc` varchar(255) NOT NULL DEFAULT '0' COMMENT '系描述',
    `ms_domain` varchar(255) NOT NULL DEFAULT '0' COMMENT '系统域名',
    `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`),
    KEY `idx_domain` (`ms_domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统map(登记目前存在的后台系统信息)';

-- 权限管理: 系统menu
CREATE TABLE `auth_ms_menu` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `ms_id` smallint(11) unsigned NOT NULL DEFAULT '0' COMMENT '系统id',
    `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父菜单id',
    `menu_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '菜单名称',
    `menu_desc` varchar(255) NOT NULL DEFAULT '0' COMMENT '菜描述',
    `menu_uri` varchar(255) NOT NULL DEFAULT '0' COMMENT '菜单uri',
    `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
    `is_show` enum('yes','no') NOT NULL DEFAULT 'no' COMMENT '是否展示菜单',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`),
    KEY `idx_ms_id` (`ms_id`),
    KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统menu';

-- 权限管理: 系统权限
CREATE TABLE `auth_item` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `ms_id` tinyint(11) unsigned NOT NULL DEFAULT '0' COMMENT '系统id',
    `menu_id` varchar(255) NOT NULL DEFAULT '0' COMMENT '页面/接口uri',
    `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`),
    KEY `idx_ms_menu` (`ms_id`, `menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统权限';

-- 权限管理: 系统权限(权限的各个集合)
CREATE TABLE `auth_role` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `name` varchar(255) NOT NULL DEFAULT '0' COMMENT '角色名称',
    `desc` varchar(255) NOT NULL DEFAULT '0' COMMENT '角描述',
    `auth_item_set` text COMMENT '权限集合 多个值,号隔开',
    `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工角色';

-- 权限管理: 角色与员工关系
CREATE TABLE `auth_role_staff` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `staff_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '员工id',
    `role_set` text COMMENT '角色集合 多个值,号隔开',
    `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
    `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建人staff_id',
    `update_at` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
    `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改人staff_id',
    `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 1:enable, 0:disable, -1:deleted',
    PRIMARY KEY (`id`),
    KEY `idx_staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限角色与员工关系';

```


## 交互设计

> 友情提示：一大波图片即将到来，此处图片较多，不清楚的可点击大图查看

### 注册

注册成功之后存在至少两种交互方式：

1. 注册成功 -> 跳转到登录页面
2. 注册成功 -> 自动登录 -> 跳转到应用首页(或者其他页面)

具体交互流程如下：

<p align="center">
    <a href="http://cdn.tigerb.cn/skr-account-register-bmpr.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-register-bmpr.png" width="39%">
    </a>
    <a href="http://cdn.tigerb.cn/skr-account-register.jpg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-register.jpg" width="90%">
    </a>
    <a href="http://cdn.tigerb.cn/skr-account-register-result-2.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-register-result-2.png" width="90%">
    </a>
</p>

--- 

### 登录

<p align="center">
    <a href="http://cdn.tigerb.cn/skr-account-login-page.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-login-page.png" width="30%">
    </a>
    <a href="http://cdn.tigerb.cn/skr-account-login-logic.jpg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-login-logic.jpg" width="90%">
    </a>
    <a href="http://cdn.tigerb.cn/skr-account-home-page.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-home-page.png" width="30%">
    </a>
</p>

##### 快捷登录

快捷登录的流程基本和上面一致只是验证密码换成了验证验证码。

<p align="center">
    <a href="http://cdn.tigerb.cn/skr-account-simple-login-page.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-simple-login-page.png" width="39%">
    </a>
</p>

---

### 第三方登录

第三方登录的交互其实存在这样的问题：

1. 第三方账户登录成功后还需要绑定手机号/Email吗？

因为我发现有些PM为了提高用户使用的简单快捷性，往往第三方登录成功后会直接产生uid，而不进行账号的绑定。这样之后在再进行账号绑定就涉及账号合并的问题，很麻烦(如果有钱包等)。如果我们一开始就进行绑定操作，这样未来账号的关系就清晰明了便于维护，第三方登录其实就相当于普通账号的别名。
最后这个事情做不做的结果就是，账户表account_user和第三方用户信息表account_platform是的**一对多**还是**一对一**的关系。

2. 如果绑定，已经注册的手机号/Email是否可以绑定？

这个还好说，一般来说绑定的选择基本是正确的。最后具体的流程图如下：


<p align="center">
    <a href="http://cdn.tigerb.cn/skr-account-platform-login.jpg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-platform-login.jpg" width="100%">
    </a>
</p>


交互界面图如下：

<p align="center">
    <a href="http://cdn.tigerb.cn/skr-account-platform-login-page.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-account-platform-login-page.png" width="39%">
    </a>
</p>

---

### 后台权限管理

首先，我们的后台管理系统需要个响亮的称号，想了一会以前公司用过apollo,于是我准备用mars但突然冒出来个earth，地球万物之根，刚好我们这又是个全业务的基础服务管理系统，哈哈就这样吧～ **Earth System**

**Earth System**的权限管理功能主要分为以下四部分：

- 系统管理(The manage system page)
    + 编辑页面
    + 列表页面
- 菜单管理(The menu page)
    + 编辑页面
    + 列表页面
- 角色管理(The role page)
    + 编辑页面
    + 列表页面
- 员工与角色关联管理(The role staff map page)
    + 编辑页面
    + 列表页面

具体交互如下：

<p align="center">
    <a href="http://cdn.tigerb.cn/skr-earth-2.jpg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-earth-2.jpg" width="100%">
    </a>
</p>

---

## 接口设计

### 应用层接口(对外)

1.注册接口

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
username|string|非必传|用户账号
email|string|email/phone两者择一|用户邮箱
phone|string|email/phone两者择一|用户手机号
code|int|必传|验证码

交互方式一(跳转到登录页面)响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": []
}
```

交互方式二(跳转到首页页面)响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "s_token": "string, 用户会话标示",
        "s_token_expire": "string, 用户会话标示过期时间，0不过期",
        "username": "string, 用户名",
        "nickname": "string, 用户昵称",
        "avatar": "string, 用户头像",
        "gender": "string, 用户性别，male:男，female:女，other:未知",
    }
}
```

2.登录接口

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
username|string|username/email/phone三者择一|用户账号
email|string|username/email/phone三者择一|用户邮箱
phone|string|username/email/phone三者择一|用户手机号
password|string|必传|密码

响应内容：
```json
{
    "code": "200",
    "result": {
        "s_token": "string, 用户会话标示",
        "s_token_expire": "string, 用户会话标示过期时间，0不过期",
        "nickname": "string, 用户昵称",
        "username": "string, 用户名",
        "avatar": "string, 用户头像",
        "gender": "string, 用户性别，male:男，female:女，other:未知",
    }
}
```

3.快捷登录接口

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
email|string|email/phone两者择一|用户邮箱
phone|string|email/phone两者择一|用户手机号
code|int|必传|验证码

响应内容：
```json
{
    "code": "200",
    "result": {
        "s_token": "string, 用户会话标示",
        "s_token_expire": "string, 用户会话标示过期时间，0不过期",
        "nickname": "string, 用户昵称",
        "username": "string, 用户名",
        "avatar": "string, 用户头像",
        "gender": "string, 用户性别，male:男，female:女，other:未知",
    }
}
```

4.第三方登录接口

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
type|string|必传|平台类型 1:facebook,2:google,3:wechat,4:qq,5:weibo,6:twitter
platform_id|string|必传|第三方平台用户ID
platform_token|string|必传|第三方平台令牌

响应内容：
```json
{
    "code": "200",
    "result": {
        "s_token": "string, 用户会话标示",
        "s_token_expire": "string, 用户会话标示过期时间，0不过期",
        "username": "string, 用户名",
        "nickname": "string, 用户昵称",
        "avatar": "string, 用户头像",
        "gender": "string, 用户性别，male:男，female:女，other:未知",
    }
}
```

5.用户信息修改接口

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
username|string|非必传|用户账号
nickname|string|非必传|昵称
avatar|string|非必传|头像url
gender|string|非必传|用户性别，male:男，female:女，other:未知

响应内容：
```json
{
    "code": "200",
    "result": {
        "username": "string, 用户名",
        "nickname": "string, 用户昵称",
        "avatar": "string, 用户头像",
        "gender": "string, 用户性别，male:男，female:女，other:未知",
    }
}
```

6.用户登录状态校验

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
s_token|string|必传|用户会话标示

响应内容：
```json
{
    "code": "200",
    "result": {
        "s_token_expire": "string, 用户会话标示过期时间，0不过期， -1登录失效",
    }
}
```

### 服务接口(基础服务，对内)

**账户服务：**

1. 注册

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
username|string|非必传|用户账号
email|string|email/phone两者择一|用户邮箱
phone|string|email/phone两者择一|用户手机号

交互方式一(跳转到登录页面)响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "uid": "string, 账户ID"
    }
}
```

2. 登录

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
username|string|非必传|用户账号
email|string|email/phone两者择一|用户邮箱
phone|string|email/phone两者择一|用户手机号
password|string|必传|密码

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "uid": "string, 账户ID"
    }
}
```

2. 第三方登录

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
type|string|必传|平台类型 1:facebook,2:google,3:wechat,4:qq,5:weibo,6:twitter
platform_id|string|必传|第三方平台用户ID
platform_token|string|必传|第三方平台令牌

响应内容：
```json
{
    "code": "200",
    "result": {
        "uid": "string, 账户ID",
        "nickname": "string, 用户昵称",
        "avatar": "string, 用户头像",
    }
}
```

**权限服务**

1. 获取系统菜单

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
ms_id|string|必传|系统ID

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": {
        "ms_name": "string, 系统名称",
        "ms_desc": "string, 系描述",
        "ms_domain": "string, 系统域名",
        "list": [
            {
                "parent_id": "string, 父菜单ID",
                "menu_id": "string, 菜单ID",
                "menu_name": "string, 菜单ID",
                "menu_desc": "string, 菜描述",
                "menu_uri": "string, 菜单uri",
                "child" : [
                    {
                        "parent_id": "string, 父菜单ID",
                        "menu_id": "string, 菜单ID",
                        "menu_name": "string, 菜单ID",
                        "menu_desc": "string, 菜描述",
                        "menu_uri": "string, 菜单uri",
                        "child" : []
                    }
                ]
            }
        ]
    }
}
```

2. 权限校验

请求参数：

字段|类型|是否必传|描述
------------|------------|------------|------------
menu_id|string|必传|菜单ID

响应内容：
```json
{
    "code": "200",
    "msg": "OK",
    "result": []
}
```


# 购物体系


## 商品系统

今天我们开始「商品系统」的篇章。本文分为如下五大模块：

- 需求分析
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
    <a href="http://cdn.tigerb.cn/skr-product-service.jpg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/skr-product-service.jpg">
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
    `name` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '品牌名称',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '品牌描述',
    `logo_url` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '品牌logo图片',
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
    `name` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '分类名称',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '分类描述',
    `pic_url` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '分类图片',
    `path` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '分类地址{pid}-{child_id}-...',
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
    `name` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT 'spu名称',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT 'spu描述',
    `selling_point` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '卖点',
    `unit` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT 'spu单位',
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
    `name` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '销售属性名称',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '销售属性描述',
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
    `value` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '销售属性值',
    `desc` varchar(255) unsigned NOT NULL DEFAULT '' COMMENT '销售属性值描述',
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

# 营销体系

耐心等待...

# 交易中心

## 常见第三方支付流程
这几年的工作中一直与支付打交到，借着 [skr-shop](https://github.com/skr-shop/manuals) 这个项目来与大家一起分享探索一下支付系统该怎么设计、怎么做。我们先从支付的一些常见流程出发分析，找出这些支付的共性，抽象后再去探讨具体的数据库设计、代码结构设计。

相关项目：

- [PHP 版本的支付SDK](https://github.com/helei112g/payment)
- [Go 版本的支付SDK-开发中](https://github.com/skr-shop/fool-pay)



> 支付整体而言的一个流程是：给第三方发起了一笔交易，用户通过第三方完成支付，第三方告诉我支付成功，我把用户购买的产品给用户。

![pay-1](https://dayutalk.cn/img/pay-1.jpg)

看似简单的流程，这里边不同的支付机构却有不同的处理。下面以我接触过的一些支付来总结一下

### 国内支付

国内的典型支付代表是：**支付宝**、**微信**、**银行**(以招商银行为例)，由于国内的支付都支持多种渠道的支付方式，为了描述简单，我们均以pc上的支付为例进行讲解。

#### 支付宝

支付宝的接入是我觉得最简单的一种支付。对于在PC上的支付能力，支付宝提供了【电脑支付】。当用户下单后，商户系统根据支付宝的规则构建好一个url，用户跳转到这个url后进入到支付宝的支付页面，然后完成支付流程。

在支付成功后，支付宝会通过 **同步通知**、**异步通知** 两种方式告诉商户系统支付成功，并且两种通知方式的结果都是可信的，而且异步通知的消息延迟也非常短暂。

对于退款流程，支付宝支持全额、部分退款。并且能够根据商户的退款单号区分是否是同一笔退款进而避免了重复退款的可能。支付的退款是调用后同步返回结果，不会异步通知。

#### 微信支付

微信并没有提供真的PC支付能力，但是我们可以利用【扫码支付】来达成电脑支付的目的。扫码支付有两种模式，这里以模式二为例。

微信调用下单接口获取到这个二维码链接，然后用户扫码后，进入支付流程。完成支付后微信会 **异步通知**，但是这里并没有 **同步通知**，因此前端页面只能通过定时轮训的方式检查这笔交易是否支付，直到查询到成功、或者用户主动关闭页面。

退款流程与支付宝最大的不同是，有一个 **异步通知** 需要商户系统进行处理。

> 第一个不同点：
>
> 1. 异步通知的接口需要处理多种不同类型的异步消息

#### 招商银行

随着在线支付在国内的蓬勃发展，各家银行也是不断推出自己的在线支付能力。其中的佼佼者当属 **招商银行**。大家经常用的滴滴上面就有该支付方式，可以体验一下。

招商支付使用的是银行卡，因此首次用户必须进行绑卡。因此这里可能就多了一个流程，首先得记录用户是否绑过卡，然后用于签名的公钥会发生变化，需要定期更新。

招商所有平台的支付体验都是一致的，会跳转到招行的H5页面完成逻辑，支付成功后并不会自动跳回商户，也就是没有 **同步通知**，它的支付结果只会走异步通知流程，延迟非常短暂。

退款流程与支付宝一样，也是同步返回退款结果，没有异步通知。

> 第二个不同点：
>
> 1. 支付前需要检查用户是否签约过，有签约流程

#### 小结

国内在线支付流程相对都比较完善，接入起来也非常容易。需要注意的一点是：退款后之前支付的单子依然是支付成功状态，并不会变成退款状态。因为退款与支付属于不同的交易。

这一点基本上是国内在线支付的通用做法。

### 国际支付

国际支付的平台非常多，包括像支付宝、微信也在扩展这一块市场。我以我接触的几家支付做一个简单的总结。

#### WorldPay

这是比较出名的一家国际支付公司，它主要做的是银行卡支付，公司在英国

支付流程上，也是根据规则构建好请求的url后，直接跳转到 **WorldPay** 的页面，通过信用卡完成支付。这里比较麻烦的处理机制是：支付成功后，他首次给你的异步/同步消息通知并不能作为支付成功的依据。真的从银行确认划款成功后，才会给出真的支付成功通知。这中间还可能会异步通知告诉你支付请求被拒绝。最头痛的是不同状态的异步消息时间间隔都是按照分钟以上级别的延迟来计算

退款流程上，状态跟微信一样，需要通过异步消息来确认退款状态。其次它的不同点在于无法根据商户退款单号来确认是否已经发起过退款，因此对于它来说只要请求一次退款接口，那它就默认发起了一次退款。

> 第三、四不同点：
>
> 1. 支付成功后的通知状态有多种，涉及到商户系统业务流程的特殊处理
>
> 1. 退款不支持商户退款单号，无法支持防重复退款需要商户自己处理

#### Assist

这是俄罗斯的一家支付公司，这也是一家搞死人不偿命的公司，看下面介绍

它的支付发起是需要构建一个form表单，向它post支付相关的数据。成功后会跳转到它的支付页，用户完成支付即可。对于 **同步通知**，它需要用户手动触发跳回商户，与招商的逻辑很像，同步也仅仅是做返回并不会真的告知支付结果。**异步通知** 才是真的告知支付状态。比较恶心的是，支付时必须传入指定格式的商品信息，这会在部分退款时用到。

现在来说退款，退款也是与 **WorldPay** 一样，不支持商户的退款单号，因此防重方面也许自己的系统进行设计。并且如果是部分退款，需要传入指定的退款商品，这就会出现一个非常尴尬的局面：部分退款的金额与任何一个商品金额都对应不上，退款则会失败。

> 第五个不同点：
>
> 1. 部分退款时需要传入部分退款的商品信息，并且金额要一致

#### Doku

接下来再来聊聊印尼的这家支付机构 **doku**。由于印尼这个国家信用卡的普及程度并不高，它的在线支付提供一种超商支付方式。

什么是超商支付呢？也就是用户在网络上完成下单后，会获取到一个二维码或者条形码。用户拿着这个条形码到超商（711、全家这种）通过收银员扫码，付现金给超商，完成支付流程。

这种方式带来的问题是，用户长时间不去支付，导致订单超时关单后才去付款。对整个业务流程以及用户体验带来很多伤害。

再来说退款，由于存在超商这种支付方式，导致这种支付无法支持在线自动退款，需要人工收集用户银行卡信息，然后完成转账操作。非常痛苦不堪。

> 第六个不同点：
>
> 1. 线上没有付款，只有获取付款码，退款需要通过人工操作

#### AmazonPay

亚马逊出品，与支付宝非常类似。提供的是集成式的钱包流程。

支付时直接构建一个url，然后跳转到亚马逊即可完成支付。它还提供一种授权模式，能够不用跳转amazon，再商户端即完成支付。

支付成功后也会同步跳转，**同步通知** 的内容可以作为支付是否成功的判断依据。经过实际检查 **异步通知** 的到达会稍有延迟，大概10s以内。

退款方面也支持商户退款单号可以依赖此进行防重。但是退款的状态也是基于异步来的。

### 总结

这其中还有一些国际支付，如：**PayPal**、**GooglePay**、**PayTM** 等知名支付机构没有进行介绍，是因为基本它们的流程也都在上面的模式之中。我们后续的代码结构设计、数据库设计都基于满足上面的各种支付模型来完成设计。

最后，赠送大家一副脑图，这是接入一家支付时必须弄清楚的问题清单

![pay-2](https://dayutalk.cn/img/pay-2.png)

## 支付系统设计

文中我们从严谨的角度一步步聊到支付如何演变成独立的系统。内容包括：系统演进过程、接口设计、数据库设计以及代码如何组织的示例。若有不足之处，欢迎讨论共同学习。

### 从模块到服务

我记得最开始工作的时候，所有的功能：加购物车/下单/支付 等逻辑都是放在一个项目里。如果一个新的项目需要某个功能，就把这个部分的功能包拷贝到新的项目。数据库也原封不动的拷贝过来，稍微根据需求改改。

这就是所谓的 **单体应用** 时代，随着公司产品线开始多元，每条产品线都需要用到支付服务。如果支付模块调整了代码，那么就会处处改动、处处测试。另一方面公司的交易数据割裂在不同的系统中，无法有效汇总统一分析、管理。

这时就到了系统演进的时候，我们把每个产品线的支付模块抽离成统一的服务。对自己公司内部提供统一的API使用，可以对这些API进一步包装成对应的SDK，供内部业务线快速接入。这里服务使用HTTP或者是RPC协议都可以根据公司实际情况决定。不过如果考虑到未来给第三方使用，建议使用HTTP协议，

**系统的演变过程：**

![image-20190309104541749](https://dayutalk.cn/img/image-20190309104541749.png)

总结下，将支付单独抽离成服务后，带来好处如下：

1. 避免重复开发，数据隔离的现象出现；
2. 支付系统周边功能演进更容易，整个系统更完善丰满。如：对账系统、实时交易数据展示；
3. 随时可对外开发，对外输出Paas能力，成为有收入的项目；
4. 专门的团队进行维护，系统更有机会演进成顶级系统；
5. 公司重要账号信息保存一处，风险更小。

### 系统能力

如果我们接手该需求，需要为公司从零搭建支付系统。我们该从哪些方面入手？这样的系统到底需要具备什么样的能力呢？

首先支付系统我们可以理解成是一个适配器。他需要把很多第三方的接口进行统一的整合封装后，对内部提供统一的接口，减少内部接入的成本。做为一个最基本的支付系统。需要对内提供如下接口出来：

1. 发起支付，我们取名：`/gopay`
2. 发起退款，我们取名：`/refund`
3. 接口异步通知，我们取名：`/notify/支付渠道/商户交易号`
4. 接口同步通知，我们取名：`/return/支付渠道/商户交易号`
5. 交易查询，我们取名：`/query/trade`
6. 退款查询，我们取名：`/query/refund`
7. 账单获取，我们取名：`/query/bill`
8. 结算明细，我们取名：`/query/settle`

一个基础的支付系统，上面8个接口是肯定需要提供的（这里忽略某些支付中的转账、绑卡等接口）。现在我们来基于这些接口看看都有哪些系统会用到。

![image-20190309111001880](https://dayutalk.cn/img/image-20190309111001880.png)

下面按照系统维度，介绍下这些接口如何使用，以及内部的一些逻辑。

#### 应用系统

一般支付网关会提供两种方式让应用系统接入：

1. 网关模式，也就是应用系统自己需要开发一个收银台；（适合提供给第三方）
2. 收银台模式，应用系统直接打开支付网关的统一收银台。（内部业务）

下面为了讲清楚设计思路，我们按照 **网关模式** 进行讲解。

对于应用系统它需要能够请求支付，也就是调用 `gopay` 接口。这个接口会处理商户的数据，完成后会调用第三方网关接口，并将返回结果统一处理后返回给应用方。

这里需要注意，第三方针对支付接口根据我的经验大致有以下情况：

1. 支付时，不需要调用第三方，按照规则生成数据即可；
2. 支付时，需要调用第三方多个接口完成逻辑（这可能比较慢，大型活动时需要考虑限流/降配）；
3. 返回的数据是一个url，可直接跳转到第三方完成支付（wap/pc站）；
4. 返回的数据是xml/json结构，需要拼装或作为参数传给她的sdk（app）。

这里由于第三方返回结构的不统一，我们需要统一处理成统一格式，返回给商户端。我推荐使用json格式。

```json
{
    "errno":0,
    "msg":"ok",
    "data":{

    }
}
```

我们把所有的变化封装在 **data** 结构中。举个例子，如果返回的一个url。只需要应用程序发起 **GET** 请求。我们可以这样返回：

```json
{
    "errno":0,
    "msg":"ok",
    "data":{
        "url":"xxxxx",
        "method":"GET"
    }
}
```

如果是返回的结构，需要应用程序直接发起 **POST** 请求。我们可以这样返回：

```json
{
    "errno":1,
    "msg":"ok",
    "data":{
        "from":"<form action="xxx" method="POST">xxxxx</form>",
        "method":"POST"
    }
}
```

这里的 **form** 字段，生成了一个form表单，应用程序拿到后可直接显示然后自动提交。当然封装成 from表单这一步也可以放在商户端进行。

上面的数据格式仅仅是一个参考。大家可根据自己的需求进行调整。

一般应用系统除了会调用发起支付的接口外，可能还需要调用 **支付结果查询接口**。当然大多数情况下不需要调用，应用系统对交易的状态只应该依赖自己的系统状态。

#### 对账系统

对于对账，一般分为两个类型：**交易对账** 与 **结算对账**

##### 交易对账

交易对账的核心点是：**检查每一笔交易是否正确**。它主要目的是看我们系统中的每一笔交易与第三方的每一笔交易是否一致。

这个检查逻辑很简单，对两份账单数据进行比较。它主要是使用 `/query/bill` 接口，拿到在第三方那边完成的交易数据。然后跟我方的交易成功数据进行比较。检查是否存在误差。

这个逻辑非常简单，但是有几点需要大家注意：

1. 我方的数据需要正常支付数据+重复支付数据的总和；
2. 对账检查不成功主要包括：**金额不对**、**第三方没有找到对应的交易数据**、**我方不存在对应的交易数据**。

针对这些情况都需要有对应的处理手段进行处理。在我的经验中上面的情况都有过遇到。

**金额不对**：主要是由于第三方的问题，可能是系统升级故障、可能是账单接口金额错误；

**第三方无交易数据：** 可能是拉去的账单时间维度问题（比如存在时差），这种时区问题需要自己跟第三方确认找到对应的时间差。也可能是被攻击，有人冒充第三方异步通知（说明系统校验机制又问题或者密钥泄漏了）。

**自己系统无交易数据：** 这种原因可能是第三方通知未发出或者未正确处理导致的。

上面这些问题的处理绝大部份都可以依赖 `query/trade`  `query/refund` 来完成自动化处理。

##### 结算对账

那么有了上面的 **交易对账** 为什么还需要 **结算对账** 呢？这个系统又是干嘛的？先来看下结算的含义。

> 结算，就是第三方网关在固定时间点，将T+x或其它约定时间的金额，汇款到公司账号。

下面我们假设结算周期是： **T+1**。结算对账主要使用到的接口是 `/query/settle`，这个接口获取的主要内容是：每一笔结算的款项都是由哪些笔交易组成（交易成功与退款数据）。以及本次结算扣除多少手续费用。

它的逻辑其实也很简单。我们先从自己的系统按照 **T+1** 的结算周期，计算出对方应该汇款给我们多少金额。然后与刚刚接口获取到的数据金额比较：

> 银行收款金额 + 手续费 = 我方系统计算的金额

这一步检查通过后，说明金额没有问题。接下来需要检查本次结算下的每一笔订单是否一致。

结算系统是 **强依赖** 对账系统的。如果对账发现异常，那么结算金额肯定会出现异常。另外结算需要注意的一些问题是：

- 银行可能会自行退款给用户，因为用户可直接向自己发卡行申请退款；
- 结算也存在时区差问题；
- 结算接口中的明细交易状态与我方并不完全一致。比如：银行结算时发现某笔退款完成，但我方系统在进行比较时按照未退款完成的逻辑在处理。

针对上面的问题，大家根据自己的业务需求需要做一些方案来进行自动化处理。

#### 财务系统

财务系统有很多内部业务，我这里只聊与支付系统相关的。（当然上面的对账系统也可以算是财务范畴）。

财务系统与支付主要的一个关系点在于校验交易、以及退款。这里校验交易可以使用 `query/trade`  `query/refund`这两个接口来完成。这个逻辑过程就不需要说了。下面重点说下退款。

我看到很多的系统退款是直接放在了应用里边，用户申请退款直接就调用退款接口进行退款。这样的风险非常高。支付系统的关于资金流向的接口一定要慎重，不能过多的直接暴露给外部，带来风险。

退款的功能应该是放到财务系统来做。这样可以走内部的审批流程（是否需要根据业务来），并且在财务系统中可以进行更多检查来觉得是否立即进行退款，或者进入等待、拒绝等流程。

#### 第三方网关

针对第三方主要使用到的其实就是异步通知与同步通知两个接口。这一部分的逻辑其实非常简单。就是根据第三方的通知完成交易状态的变更。以及通知到自己对应的应用系统。

这部分比较复杂的是，第三方的通知数据结构不统一、通知的类型不统一。比如：有的退款是同步返回结果、有的是异步返回结果。这里如何设计会在后面的 **系统设计** 中给出答案。

### 数据库设计

数据的设计是按照：交易、退款、日志 来设计的。对于上面说到的对账等功能并没有。这部分不难大家可以自行设计，按照上面讲到的思路。主要的表介绍如下：

- `pay_transaction` 记录所有的交易数据。
- `pay_transaction_extension` 记录每次向第三方发起交易时，生成的交易号
- `pay_log_data` 所有的日志数据，如：支付请求、退款请求、异步通知等
- `pay_repeat_transaction` 重复支付的数据
- `pay_notify_app_log` 通知应用程序的日志
- `pay_refund` 记录所有的退款数据

**具体的表结构：**

```sql
-- -----------------------------------------------------
-- Table 创建支付流水表
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_transaction` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_id` VARCHAR(32) NOT NULL COMMENT '应用id',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式id，可以用来识别支付，如：支付宝、微信、Paypal等',
  `app_order_id` VARCHAR(64) NOT NULL COMMENT '应用方订单号',
  `transaction_id` VARCHAR(64) NOT NULL COMMENT '本次交易唯一id，整个支付系统唯一，生成他的原因主要是 order_id对于其它应用来说可能重复',
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
  `notify_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '收到异步通知的时间',
  `finish_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '通知上游系统的时间',
  `trade_no` VARCHAR(64) NOT NULL COMMENT '第三方的流水号',
  `transaction_code` VARCHAR(64) NOT NULL COMMENT '真实给第三方的交易code，异步通知的时候更新',
  `order_status` TINYINT NOT NULL DEFAULT 0 COMMENT '0:等待支付，1:待付款完成， 2:完成支付，3:该笔交易已关闭，-1:支付失败',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `create_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建的ip，这可能是自己服务的ip',
  `update_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新的ip',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uniq_tradid` (`transaction_id`),
  INDEX `idx_trade_no` (`trade_no`),
  INDEX `idx_ctime` (`create_at`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '发起支付的数据';

-- -----------------------------------------------------
-- Table 交易扩展表
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_transaction_extension` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` VARCHAR(64) NOT NULL COMMENT '系统唯一交易id',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `transaction_code` VARCHAR(64) NOT NULL COMMENT '生成传输给第三方的订单号',
  `call_num` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '发起调用的次数',
  `extension_data` TEXT NOT NULL COMMENT '扩展内容，需要保存：transaction_code 与 trade no 的映射关系，异步通知的时候填充',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `create_ip` INT UNSIGNED NOT NULL COMMENT '创建ip',
  PRIMARY KEY (`id`),
  INDEX `idx_trads` (`transaction_id`, `pay_status`),
  UNIQUE INDEX `uniq_code` (`transaction_code`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '交易扩展表';

-- -----------------------------------------------------
-- Table 交易系统全部日志
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_log_data` (
  `id` BIGINT UNSIGNED NOT NULL,
  `app_id` VARCHAR(32) NOT NULL COMMENT '应用id',
  `app_order_id` VARCHAR(64) NOT NULL COMMENT '应用方订单号',
  `transaction_id` VARCHAR(64) NOT NULL COMMENT '本次交易唯一id，整个支付系统唯一，生成他的原因主要是 order_id对于其它应用来说可能重复',
  `request_header` TEXT NOT NULL COMMENT '请求的header 头',
  `request_params` TEXT NOT NULL COMMENT '支付的请求参数',
  `log_type` VARCHAR(10) NOT NULL COMMENT '日志类型，payment:支付; refund:退款; notify:异步通知; return:同步通知; query:查询',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `create_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建ip',
  PRIMARY KEY (`id`),
  INDEX `idx_tradt` (`transaction_id`, `log_type`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '交易日志表';


-- -----------------------------------------------------
-- Table 重复支付的交易
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_repeat_transaction` (
  `id` BIGINT UNSIGNED NOT NULL,
  `app_id` VARCHAR(32) NOT NULL COMMENT '应用的id',
  `transaction_id` VARCHAR(64) NOT NULL COMMENT '系统唯一识别交易号',
  `transaction_code` VARCHAR(64) NOT NULL COMMENT '支付成功时，该笔交易的 code',
  `trade_no` VARCHAR(64) NOT NULL COMMENT '第三方对应的交易号',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式',
  `total_fee` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易金额',
  `scale` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '小数位数',
  `currency_code` CHAR(3) NOT NULL DEFAULT 'CNY' COMMENT '支付选择的币种，CNY、HKD、USD等',
  `payment_time` INT NOT NULL COMMENT '第三方交易时间',
  `repeat_type` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '重复类型：1同渠道支付、2不同渠道支付',
  `repeat_status` TINYINT UNSIGNED DEFAULT 0 COMMENT '处理状态,0:未处理；1:已处理',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_at` INT UNSIGNED NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_trad` ( `transaction_id`),
  INDEX `idx_method` (`pay_method_id`),
  INDEX `idx_time` (`create_at`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '记录重复支付';


-- -----------------------------------------------------
-- Table 通知上游应用日志
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pay_notify_app_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_id` VARCHAR(32) NOT NULL COMMENT '应用id',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式',
  `transaction_id` VARCHAR(64) NOT NULL COMMENT '交易号',
  `transaction_code` VARCHAR(64) NOT NULL COMMENT '支付成功时，该笔交易的 code',
  `sign_type` VARCHAR(10) NOT NULL DEFAULT 'RSA' COMMENT '采用的签名方式：MD5 RSA RSA2 HASH-MAC等',
  `input_charset` CHAR(5) NOT NULL DEFAULT 'UTF-8',
  `total_fee` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '涉及的金额，无小数',
  `scale` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '小数位数',
  `pay_channel` VARCHAR(64) NOT NULL COMMENT '支付渠道',
  `trade_no` VARCHAR(64) NOT NULL COMMENT '第三方交易号',
  `payment_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付时间',
  `notify_type` VARCHAR(10) NOT NULL DEFAULT 'paid' COMMENT '通知类型，paid/refund/canceled',
  `notify_status` VARCHAR(7) NOT NULL DEFAULT 'INIT' COMMENT '通知支付调用方结果；INIT:初始化，PENDING: 进行中；  SUCCESS：成功；  FAILED：失败',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0,
  `update_at` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `idx_trad` (`transaction_id`),
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
  `app_refund_no` VARCHAR(64) NOT NULL COMMENT '上游的退款id',
  `transaction_id` VARCHAR(64) NOT NULL COMMENT '交易号',
  `trade_no` VARCHAR(64) NOT NULL COMMENT '第三方交易号',
  `refund_no` VARCHAR(64) NOT NULL COMMENT '支付平台生成的唯一退款单号',
  `pay_method_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付方式',
  `pay_channel` VARCHAR(64) NOT NULL COMMENT '选择的支付渠道，比如：支付宝中的花呗、信用卡等',
  `refund_fee` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '退款金额',
  `scale` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '小数位数',
  `refund_reason` VARCHAR(128) NOT NULL COMMENT '退款理由',
  `currency_code` CHAR(3) NOT NULL DEFAULT 'CNY' COMMENT '币种，CNY  USD HKD',
  `refund_type` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '退款类型；0:业务退款; 1:重复退款',
  `refund_method` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '退款方式：1自动原路返回; 2人工打款',
  `refund_status` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0未退款; 1退款处理中; 2退款成功; 3退款不成功',
  `create_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `create_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '请求源ip',
  `update_ip` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '请求源ip',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uniq_refno` (`refund_no`),
  INDEX `idx_trad` (`transaction_id`),
  INDEX `idx_status` (`refund_status`),
  INDEX `idx_ctime` (`create_at`)),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '退款记录';
```



表的使用逻辑进行下方简单描述：

**支付**，首先需要记录请求日志到 `pay_log_data`中，然后生成交易数据记录到 `pay_transaction`与`pay_transaction_extension` 中。

**收到通知**，记录数据到 `pay_log_data` 中，然后根据时支付的通知还是退款的通知，更新 `pay_transaction` 与 `pay_refund` 的状态。如果是重复支付需要记录数据到 `pay_repeat_transaction` 中。并且将需要通知应用的数据记录到 `pay_notify_app_log`，这张表相当于一个消息表，会有消费者会去消费其中的内容。

**退款** 记录日志日志到 `pay_log_data` 中，然后记录数据到退款表中 `pay_refund`。

当然这其中还有些细节，需要大家自己看了表结构，实际去思考一下该如何使用。如果有任何疑问欢迎到我们GitHub的项目（点击阅读原文）中留言，我们都会一一解答。

> 这些表能够满足最基本的需求，其它内容可根据自己的需求进行扩张，比如：支持用户卡列表、退款走银行卡等。

### 系统设计

这部分主要说下系统该如何搭建，以及代码组织方式的建议。

#### 系统架构

由于支付系统的安全性非常高，因此不建议将对应的入口直接暴露给用户可见。应该是在自己的应用系统中调用支付系统的接口来完成业务。另外系统对数据要求是：强一致性的。因此也没有缓存介入（当如缓存可以用来做报警，这不在本文范畴）。

![image-20190309135800643](https://dayutalk.cn/img/image-20190309135800643.png)

具体的实现，系统会使用两个域名，一个为内部使用，只有指定来源的ip能够访问固定功能（访问除通知外的其它功能）。另一个域名只能访问 `notify` `return` 两个路由。通过这种方式可以保证系统的安全。

在数据库的使用上无论什么请求直接走 **Master** 库。这样保证数据的强一致。当然从库也是需要的。比如：账单、对账相关逻辑我们可以利用从库完成。

#### 代码设计

不管想做什么最终都要用代码来实现。我们都知道需要可维护、可扩展的代码。那么具体到支付系统你会怎么做呢？我已支付为例说下我的代码结构设计思路。仅供参考。比如我要介入：微信、支付宝、招行 三家支付。我的代码结构图如下：

![image-20190309142925499](https://dayutalk.cn/img/image-20190309142925499.png)

用文字简单介绍下。我会将每一个第三方封装成： `XXXGateway` 类，内部是单纯的封装第三方接口，不管对方是 HTTP 请求还是 SOAP 请求，都在内部进行统一处理。

另外有一层`XXXProxy` 来封装这些第三方提供的能力。这一层主要干两件事情：对传过来请求支付的数据进行个性化处理。对返回的结构进行统一处理返回上层统一的结构。当然根据特殊情况这里可以进行一切业务处理；

通过上面的操作变化已经基本上被完全封装了。如果新增一个支付渠道。只需要增加：`XXXGateway ` 与 `XXXProxy`。

那么 `Context` 与 `Server` 有什么用呢？`Server` 内部封装了所有的业务逻辑，它提供接口给 action 或者其它 server 进行调用。而 `Context` 这一层存在的价值是处理 `Proxy` 层返回的错误。以及在这里进行报警相关的处理。

上面的结构只是我的一个实践，欢迎大家讨论。

本文描述的系统只是满足了最基本的支付需求。缺少相关的监控、报警。如果你按照上文设计自己的系统，风险自担与我无关。

# 订单中心

耐心等待...

# 仓储系统

耐心等待...

# 物流系统

耐心等待...

# 售后服务

耐心等待...

# 基础服务

耐心等待...
