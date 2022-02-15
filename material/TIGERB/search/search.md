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

# 由浅到深入门搜索原理

上中下三部分，由简到繁。

上部：了解基本结构&认识分析器。

- 搜索引擎ES的诞生
- 最简易的搜索过程
    + 第一部分：索引(动词)数据的过程
    + 第二部分：用户使用Query查询的过程
- 索引(动词)数据过程解析
    + 简易版本
    + 概念解释：倒排索引
    + 稍微复杂版本：引入分析器
        * 分析器的组成
        * 分析器每部分的作用
- 用户使用Query查询过程解析
    + 简易版本
    + 稍复杂版本：引入分析器
- 重要结论：索引(动词)数据的过程和Query查询的过程都使用了分析器。
    + 为什么必须是相同的分析器？
    + 合并以上全部过程

中部：了解索引(名词)的构成。

- 索引(名词)的构成
- 进一步完善搜索过程：加入详细的索引(名词)结构

扩展内容：ES的逻辑结构。

下部：了解排序的简易原理。

- 排序
    + 粗排
        * 文档率：tf(Term Frequent)
        * 逆文档率：idf(Inverse Document Frequent)
    + 精排

同时，本篇文章会涉及如下概念：

搜索名词概念|描述
------|------
索引(动词)|？
索引(名词)|？
倒排索引(Inverted Index)|？
关键字(Query)|？
文档(Doc)|？
词条(Term)|？
召回(Recall)|？
粗排|？
tf/idf|？
精排|？

我们会在上中下三部分内容中逐步揭盖这些概念的面纱。聊搜索一定离不开「搜索引擎」，所以我们首先来看看「搜索引擎」(本文均以Elasticsearch为例)的诞生。

## 搜索引擎ES的诞生

诞生于一个开源的JAVA库`Lucene`。通过`Lucene`官网的描述我们可以发现：

- `Lucene`是一个JAVA库
- `Lucene`实现了拼写检查
- `Lucene`实现了命中字符高亮
- `Lucene`实现了分析、分词功能

<p align="center">
    <a href="http://cdn.tigerb.cn/20220215203335.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220215203335.png" style="width:66%">
    </a>
</p>

多年之前一名名叫`Shay Banon`的开发者，通过`Lucene`实现了一个高可用的开源分布式搜索引擎`Elasticsearch`。

<p align="center">
    <a href="http://cdn.tigerb.cn/20220215203346.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220215203346.png" style="width:66%">
    </a>
</p>

常见的搜索功能都是基于「搜索引擎」实现的。接着我们来看看**最简易搜索过程**。

## 最简易搜索过程

本文都以业界比较出名的开源搜索引擎ES(Elasticsearch)为例来介绍，下文简称ES。

一般来说最简单的搜索过程过程如下：

- 第①步：索引(动词)数据，需要被搜索到源数据被索引(动词)到搜索引擎中，并建立索引(名词)
- 第②步：用户使用Query查询的过程，用户输入关键字(Query)，搜索引擎分析Query并返回数据

<p align="center">
    <a href="http://cdn.tigerb.cn/20220215132138.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220215132138.png" style="width:39%">
    </a>
</p>

这里提到了「索引(动词)」、「索引(名词)」名词的概念：

搜索名词概念|描述
------|------
索引(动词)✅|把源数据写入到搜索引擎的过程，称之为索引的过程。
索引(名词)✅|索引的过程产生的结果，称之为索引。
倒排索引(Inverted Index)|？
关键字(Query)|？
文档(Doc)|？
词条(Term)|？
召回(Recall)|？
粗排|？
tf/idf|？
精排|？

把①、②步拆解来看，首先来看「索引(动词)数据」的过程。

## 索引(动词)数据过程解析

先来看看第一步索引源数据的过程。

### 简易版本

简单来看：
1. 首先，同步源数据到搜索引擎
2. 接着，搜索引擎建立索引

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183509.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183509.png" style="width:66%">
    </a>
</p>

搜索引擎使用的是「倒排索引」，在进一步细化索引源数据过程之前，我们来看一个概念「倒排索引」。

### 概念解释：倒排索引

「倒排索引」就是上述索引(动词)源数据时，创建的索引(名词)的具体实现。

概念：
- 文档(doc)：需要被搜索的文本内容，可以是商品信息、网页信息等等文本。
- 词条(term)：把被搜索的文本内容拆解成N个标准的词句。

文档ID|文档内容(doc)
------|------
1|电商设计手册SkrShop
2|秒杀是电商的一种营销手段
3|《电商设计手册SkrShop》支付整体而言的一个流程是：给第三方发起了一笔交易，用户通过第三方完成支付，第三方告诉我支付成功，我把用户购买的产品给用户。

分词器 文档text ---转换成---> N个词条terms

开源中文分词器：

- IK Analyzer
- jieba
- 等

以jieba分词器在线演示为例：https://app.gumble.pw/jiebademo/

文档ID|文档内容(doc)|中文分词结果(terms)
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

以上就是建立倒排索引的基础过程。

完成倒排索引建立之后：

- 搜索`电商`就能快速找到文档1、2、3
- 搜索`营销`就能快速找到文档2

(这个过程叫做召回)

以上就是「倒排索引」的概念。

这里提到了「倒排索引」、「文档(Doc)」、「词条(Term)」名词的概念：

搜索名词概念|描述
------|------
索引(动词)|把源数据写入到搜索引擎的过程，称之为索引的过程。
索引(名词)|索引的过程产生的结果，称之为索引。
倒排索引(Inverted Index)✅|索引(动词)源数据时，创建的索引(名词)的具体实现。
关键字(Query)|？
文档(Doc)✅|源数据文本被称之为文档
词条(Term)✅|文档被分词器分解成多个短语称之为词条
召回(Recall)✅|搜索引擎利用倒排索引，通过词条获取相关文档的过程。
粗排|？
tf/idf|？
精排|？

### 稍复杂版本：引入分析器

上述分词器之是分析器的一部分，分析器基本组成：

- 分词器
- 字符过滤器
- 分词过滤器

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183541.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183541.png" style="width:50%">
    </a>
</p>

#### 分析器之字符过滤器

格式化为标准文本(text -> standard text)，例如去掉文本中的html标签

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183701.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183701.png" style="width:50%">
    </a>
</p>

比如`<p>电商设计手册SkrShop</p>`--->`电商设计手册SkrShop`

#### 分析器之分词器

上述讲解「倒排索引」的过程中已经演示了分词器的作用

文本块拆为独立词条(text -> terms)

自定义词库

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183714.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183714.png" style="width:50%">
    </a>
</p>

比如`电商设计手册SkrShop`--->`电商 / 设计 / 手册 / SkrShop`

#### 分析器之分词过滤器

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


分析就是把文档文本标准化的过程。

## 用户使用Query查询过程解析

### 简易版本

<p align="center">
    <a href="http://cdn.tigerb.cn/20220215205523.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220215205523.png" style="width:30%">
    </a>
</p>

搜索名词概念|描述
------|------
索引(动词)|把源数据写入到搜索引擎的过程，称之为索引的过程。
索引(名词)|索引的过程产生的结果，称之为索引。
倒排索引(Inverted Index)|索引(动词)源数据时，创建的索引(名词)的具体实现。
关键字(Query)✅|发起搜索是用户输入的关键字
文档(Doc)|源数据文本被称之为文档
词条(Term)|文档被分词器分解成多个短语称之为词条
召回(Recall)|搜索引擎利用倒排索引，通过词条获取相关文档的过程。
粗排|？
tf/idf|？
精排|？

### 稍微复杂版本：引入分析器

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129185552.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129185552.png" style="width:66%">
    </a>
</p>

## 得到一个重要的结论

通过上述的分析我们很容易得到一个结论：

> 索引(动词)数据的过程和Query查询的过程都使用了分析器。

### 为什么必须是相同的分析器？

保证

索引(动词)数据过程中：text -> terms的结果

和

用户使用Query查询的过程：query -> terms的结果

一致。

保证数据(doc)的正常召回。

## 合并以上全部过程

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129190440.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129190440.png" style="width:66%">
    </a>
</p>

## 上半部分总结

上半部分结束，通过这部分我们了解了基本结构、初步认识了分析器。开始下半部分。

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129191249.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129191249.png" style="width:66%">
    </a>
</p>

## 索引(名词)的构成

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129190541.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129190541.png" style="width:66%">
    </a>
</p>

## 进一步完善搜索过程：加入更详细的索引(名词)结构

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129191354.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129191354.png" style="width:66%">
    </a>
</p>

## 进一步进阶：ES的逻辑结构

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129191435.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129191435.png" style="width:100%">
    </a>
</p>

以上内容其实只包含了基础搜索过程的其中两步：

- 索引(动词)数据过程，也就是创建倒排索引的过程
- doc召回过程

对于基础的搜索过程核心还差「排序过程」。基础的搜索过程包含三大部分：

- 创建倒排索引：索引(动词)数据得到索引(名词)
- 召回数据
- 排序
    + 粗排
    + 精排

召回数据之后，你怎么知道docs应该按什么样的顺序排列呢？

相关性 score

- 文档率：tf(Term Frequent)
- 逆文档率：idf(Inverse Document Frequent)


以上是粗排

精排