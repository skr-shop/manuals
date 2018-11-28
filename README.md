<h1 align="center">《电商设计手册》</h1>

<p align="center">Do design No code | 只设计不码码</p>

<p align="center"><a href="http://skrshop.tech/">skrshop.tech</a></p>


# 目录

- [前言](?id=前言)
- [技术栈选型](?id=技术栈选型)
- [代码仓库](?id=代码仓库)
- [用户体系](?id=用户体系)
- [BUY服务](?id=BUY服务)
    + 商品系统(Temporal万物)
- [交易中心](?id=交易中心)
    + 常见第三方支付流程
    + 支付系统
    + 对账系统
- [订单中心](?id=订单中心)
- [仓储系统](?id=仓储系统)
    + 地址服务
- [物流系统](?id=物流系统)
- [售后服务](?id=售后服务)
- [基础服务](?id=基础服务)

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
    KEY `idx_domain` (`domain`)
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


# BUY服务

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

## 支付系统
即将上线

## 对账系统
耐心等待...

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