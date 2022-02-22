# 电商搜索业务介绍

搜索业务涉及的关键词如下：

- 搜索框
- 搜索底纹
- 搜索建议词
- 搜索直达
- 搜索历史词
- 搜索热词
- 搜索激活页
- 搜索结果页

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129182049.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129182049.png" style="width:80%">
    </a>
</p>

我们按搜索过程归类：

搜索过程：

- 搜索前
- 搜索中
- 搜索后

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129182113.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129182113.png" style="width:100%">
    </a>
</p>


# 搜索前

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129182129.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129182129.png" style="width:100%">
    </a>
</p>


## 搜索框 

<p align="center">
    <a href="http://cdn.tigerb.cn/20220107213721.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107213721.png" style="width:36%">
    </a>
</p>

## 搜索底纹

<p align="center">
    <a href="http://cdn.tigerb.cn/20220107213720.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107213720.png" style="width:36%">
    </a>
</p>

# 搜索中

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129182149.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129182149.png" style="width:100%">
    </a>
</p>

## 搜索激活页

<p align="center">
    <a href="http://cdn.tigerb.cn/20220107214238.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107214238.png" style="width:36%">
    </a>
</p>

## 搜索建议词

### 普通搜索建议词

<p align="center">
    <a href="http://cdn.tigerb.cn/20220107213714.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107213714.png" style="width:36%">
    </a>
</p>

### 搜索直达

#### 活动直达

<p align="center">
    <a href="" data-lightbox="roadtrip">
        <img src="" style="width:36%">
    </a>
</p>

#### 商品直达

<p align="center">
    <a href="" data-lightbox="roadtrip">
        <img src="" style="width:36%">
    </a>
</p>

## 搜索热词

<p align="center">
    <a href="http://cdn.tigerb.cn/20220107213712.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107213712.png" style="width:36%">
    </a>
</p>

## 搜索历史词

<p align="center">
    <a href="http://cdn.tigerb.cn/20220107213713.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107213713.png" style="width:36%">
    </a>
</p>

# 搜索后

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129182208.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129182208.png" style="width:100%">
    </a>
</p>

## 搜索结果页面

<p align="center">
    <a href="http://cdn.tigerb.cn/20220107213716.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107213716.png" style="width:36%">
    </a>
</p>

## 大搜

<p align="center">
    <a href="" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107213717.png" style="width:36%">
    </a>
</p>

## 垂搜

<p align="center">
    <a href="http://cdn.tigerb.cn/20220107213715.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107213715.png" style="width:36%">
    </a>
</p>

## 纠错

### 强纠错

<p align="center">
    <a href="" data-lightbox="roadtrip">
        <img src="" style="width:36%">
    </a>
</p>

### 中纠错

<p align="center">
    <a href="http://cdn.tigerb.cn/20220107214840.jpg" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220107214840.jpg" style="width:36%">
    </a>
</p>


### 弱纠错

<p align="center">
    <a href="" data-lightbox="roadtrip">
        <img src="" style="width:36%">
    </a>
</p>

# 总结

<p align="center">
    <a href="http://cdn.tigerb.cn/20220109223034.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220109223034.png" style="width:100%">
    </a>
</p>

------

# 由浅到深入门搜索原理

> 本文均以开源搜索引擎ES(Elasticsearch)为例，下文简称ES。

首先，本篇文章对于初次接触的同学来讲，涉及的概念会比较多，主要如下：

搜索名词概念|描述
------|------
倒排索引(Inverted Index)|？
关键字(Query)|？
文档(Doc)|？
词条(Term)|？
召回(Recall)|？
粗排|？
词频(tf:Term Frequent)|？
逆文档率(idf:Inverse Document Frequent)|？
精排|？

本篇文章由简到繁入门搜索原理，并逐步揭盖这些概念的面纱。本文结构如下：

- 搜索引擎ES的诞生
- 简易版搜索过程
    + 索引过程
    + 查询过程
- 进阶版搜索过程
    + 索引过程
        * 什么是文档(Doc)
        * 什么是词条(Term)
        * 什么是倒排索引(Inverted Index)
        * 文档(Doc)分析
            - 字符过滤器
            - 分词器
            - 分词过滤器
        * 创建倒排索引
        * 索引过程总结
    + 查询过程
        * 关键字(Query)分析
            - 字符过滤器
            - 分词器
            - 分词过滤器
        * 召回(Recall)
            - 什么是召回(Recall)
        * 排序
            - 粗排
                + 什么是词频(tf:Term Frequent)
                + 什么是逆文档率(idf:Inverse Document Frequent)
            - 精排
        * 查询过程总结
    + 搜索过程总结
- 搜索引擎ES进阶
    + 索引(名词)的基本结构
    + 搜索引擎ES的逻辑结构

## 搜索引擎ES的诞生

ES诞生于一个开源的JAVA库`Lucene`。通过`Lucene`官网的描述我们可以发现`Lucene`具备如下能力：

- `Lucene`是一个JAVA库
- `Lucene`实现了拼写检查
- `Lucene`实现了命中字符高亮
- `Lucene`实现了分析、分词功能

`Lucene`不具备的能力：

- 分布式
- 高可用
- 快速上手的能力
- 等等

<p align="center">
    <a href="http://cdn.tigerb.cn/20220215203335.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220215203335.png" style="width:66%">
    </a>
</p>

所以多年之前名叫`Shay Banon`的开发者，通过`Lucene`实现了一个高可用的开源分布式搜索引擎`Elasticsearch`。

<p align="center">
    <a href="http://cdn.tigerb.cn/20220215203346.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220215203346.png" style="width:66%">
    </a>
</p>

常见的搜索功能都是基于「搜索引擎」实现的，接着我们来看看**简易版搜索过程**。

## 简易版搜索过程

简易版搜索过程如下：

- 第①步：索引过程，需要被搜索的源数据被索引(动词)到搜索引擎中，并建立索引(名词)。
- 第②步：查询过程，用户输入关键字(Query)，搜索引擎分析Query并返回查询结果。

<p align="center">
    <a href="http://cdn.tigerb.cn/20220215132138.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220215132138.png" style="width:39%">
    </a>
</p>

## 进阶版搜索过程

### 索引过程

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183509.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183509.png" style="width:50%">
    </a>
</p>

#### 什么是文档(Doc)

举个栗子，比如《电商设计手册 | SkrShop》网页内容需要被搜索到，那这页网页的全部内容就称之为一个`文档Doc`。

<p align="center">
    <a href="http://cdn.tigerb.cn/20220222131248.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220222131248.png" style="width:80%">
    </a>
</p>

`文档Doc`内容如下：

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>电商设计手册 | SkrShop</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="description" content="应该是最全、最细致、最落地的电商系统设计手册">
  <!-- 省略...... -->
  <p>秒杀是电商的一种营销手段</p>
  <!-- 省略...... -->
```

搜索名词概念|描述
------|------
文档(doc)|需要被搜索的文本内容，可以是某个商品详细信息、某个网页信息等等文本。

#### 什么是词条(Term)

继续以上文的`文档Doc`为例。为了简化对`词条(Term)`的理解，把上述`文档Doc`的内容简化为一句话`秒杀是电商的一种营销手段`。

`词条(Term)`就是`文档Doc`经过分词处理得到的词条结果集合。比如`秒杀是电商的一种营销手段`被中文分词之后得到：

```
秒杀 / 是 / 电商 / 的 / 一种 / 营销 / 手段
```

秒杀、是、电商、的、一种、营销、手段分别称之为`词条(Term)`，该集合称之为`Terms`。

搜索名词概念|描述
------|------
词条(Term)|被搜索的文本Doc被分词器拆解成N个标准的语句。

#### 什么是倒排索引(Inverted Index)

「倒排索引」就是上述索引(动词)源数据时，创建的索引(名词)的具体实现。

我们以如下文档(Doc)为例解释倒排索引：

文档ID|文档内容(Doc)
------|------
1|电商设计手册SkrShop
2|秒杀是电商的一种营销手段
3|购物车是电商购买流程最重要的一步

分词器：文档(Doc)拆解为多个独立词条(Doc -> Terms)。

开源中文分词器：

- IK Analyzer
- jieba
- 等

以jieba分词器在线演示为例：https://app.gumble.pw/jiebademo/

文档ID|文档内容(Doc)|中文分词结果(Terms)
------|------|------
1|电商设计手册SkrShop|电商 / 设计 / 手册 / SkrShop
2|秒杀是电商的一种营销手段|秒杀 / 是 / 电商 / 的 / 一种 / 营销 / 手段
3|购物车是电商购买流程最重要的一步|购物车 / 是 / 电商 / 购买 / 流程 / 最 / 重要 / 的 / 一步

每个词条对应的文档ID如下：

词条|文档IDs
------|------
电商|1、2、3
设计|1
手册|1
SkrShop|1
秒杀|2
是|2、3
的|2、3
一种|2
营销|2
手段|2
购物车|3
购买|3
流程|3
最|3
重要|3
一步|3

以上就是建立倒排索引的基本过程。

完成倒排索引建立之后，模拟搜索过程，假设：

- 搜索`电商`，能快速找到文档1、2、3
- 搜索`营销`，能快速找到文档2

(这个过程叫做「召回」)

以上就是「倒排索引」的概念。

搜索名词概念|描述
------|------
倒排索引(Inverted Index)|索引(动词)源数据时，创建的索引(名词)的具体实现。
召回(Recall)|搜索引擎利用倒排索引，通过词条获取相关文档的过程。

#### 文档(Doc)分析

分析就是标准化文档(Doc)文本，以及把文档(Doc)转换成标准化词条(Term)的过程。搜索引擎ES分析过程的实现依赖于分词器。分析器基本组成：

- 字符过滤器
- 分词器
- 分词过滤器

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183541.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183541.png" style="width:50%">
    </a>
</p>

##### 字符过滤器

格式化为标准文本(text -> standard text)，例如去掉文本中的html标签。

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183701.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183701.png" style="width:50%">
    </a>
</p>

比如`<p>电商设计手册SkrShop</p>`--->`电商设计手册SkrShop`

##### 分词器

文档(Doc)拆解为多个独立词条(doc -> terms)的过程。举个例子：
比如`电商设计手册SkrShop`--->`电商 / 设计 / 手册 / SkrShop`

自定义词库

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183714.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183714.png" style="width:50%">
    </a>
</p>

##### 分词过滤器

- 统一转小写
- 近义词转换
- 停用词
- 提取词干
- 纠错
- 自动补全
- 等等...

<p align="center">
    <a href="http://cdn.tigerb.cn/20220215205418.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220215205418.png" style="width:50%">
    </a>
</p>

分词过滤器|示例
------|------
统一转小写|适用于英文等。比如统一把英文字母转换为小写，例`Word -> word`
近义词转换|适用于各语言。例`宽敞 -> 宽阔`
停用词|适用于各语言。去除含义宽泛不具备代表性的词语和其他人工指定停用的词语，例`的`、`是`。中文停用词库：github.com/goto456/stopwords
提取词干|适用于英文等。例`words -> word`
纠错|适用于各语言。例`宽肠 -> 宽敞`
自动补全|适用于各语言。

#### 创建倒排索引
### 查询过程

<p align="center">
    <a href="http://cdn.tigerb.cn/20220215205523.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220215205523.png" style="width:20%">
    </a>
</p>

搜索名词概念|描述
------|------
关键字(Query)|发起搜索是用户输入的关键字

#### 关键字(Query)分析

<p align="center">
    <a href="http://cdn.tigerb.cn/20220220211920.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220220211920.png" style="width:39%">
    </a>
</p>

#### 召回(Recall)

##### 什么是召回(Recall)

搜索名词概念|描述
------|------
召回(Recall)|搜索引擎利用倒排索引，通过词条获取相关文档的过程。

词条|文档IDs
------|------
电商|1、2、3
设计|1
手册|1
SkrShop|1
秒杀|2
是|2、3
的|2、3
一种|2
营销|2
手段|2
购物车|3
购买|3
流程|3
最|3
重要|3
一步|3

模拟搜索过程，假设：

- 搜索`电商`，能快速找到文档1、2、3
- 搜索`营销`，能快速找到文档2

#### 排序

搜索`电商`，能快速找到文档1、2、3

文档1、2、3谁在前谁在后，它们的顺序怎么决定的呢？
答：相关性 相关性打分 score。

- 文档率：tf(Term Frequent)
- 逆文档率：idf(Inverse Document Frequent)

###### 什么是词频(tf:Term Frequent)

文档ID|文档内容(doc)|中文分词结果(terms)
------|------|------
1|电商设计手册SkrShop|电商 / 设计 / 手册 / SkrShop
2|秒杀是电商的一种营销手段|秒杀 / 是 / 电商 / 的 / 一种 / 营销 / 手段
3|购物车是电商购买流程最重要的一步|购物车 / 是 / 电商 / 购买 / 流程 / 最 / 重要 / 的 / 一步


比如，`电商`一词在文档1中出现的频率，以单个文档的全部内容为维度。

###### 什么是逆文档率(idf:Inverse Document Frequent)

文档ID|文档内容(doc)|中文分词结果(terms)
------|------|------
1|电商设计手册SkrShop|电商 / 设计 / 手册 / SkrShop
2|秒杀是电商的一种营销手段|秒杀 / 是 / 电商 / 的 / 一种 / 营销 / 手段
3|购物车是电商购买流程最重要的一步|购物车 / 是 / 电商 / 购买 / 流程 / 最 / 重要 / 的 / 一步

先看`文档率`

比如，`电商`一词在所有文档中出现的频率，以所有文档为维度。

##### 粗排

##### 精排

#### 查询过程总结

通过上述的分析我们很容易得到一个结论：

> 索引(动词)数据的过程和Query查询的过程都使用了分析器。

为什么必须是相同的分析器？

保证

索引(动词)数据过程中：text -> terms的结果

和

用户使用Query查询的过程：query -> terms的结果

一致。

保证数据(doc)的正常召回。

### 搜索过程总结

<p align="center">
    <a href="http://cdn.tigerb.cn/20220220212012.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220220212012.png" style="width:50%">
    </a>
</p>

## 搜索引擎ES进阶

### 索引(名词)的基本结构

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129190541.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129190541.png" style="width:50%">
    </a>
</p>

进一步完善搜索过程：加入更详细的索引(名词)结构

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129191354.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129191354.png" style="width:50%">
    </a>
</p>

### 搜索引擎ES的逻辑结构

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129191435.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129191435.png" style="width:50%">
    </a>
</p>