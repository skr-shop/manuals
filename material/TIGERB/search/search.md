# 电商搜索业务介绍

搜索业务涉及的关键词如下：

- 搜索框
- 搜索底纹
- 搜索建议词
- 搜索直达
- 搜索历史词
- 搜索热词
- 搜索激活页面
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

## 搜索激活页面

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

上中下三部分。

上部：了解基本结构&认识分析器。

- 最简易的搜索过程
    + 第一部分：索引(动词)数据的过程
    + 第二部分：用户使用Query查询的过程
- 介绍索引(动词)数据的过程
    + 简易版本
    + 概念解释：倒排索引
    + 稍微复杂版本：引入分析器
        * 分析器的组成
        * 分析器每部分的作用
- 介绍用户使用Query查询的过程
    + 简易版本
    + 稍微复杂版本：引入分析器
- 得到一个重要的结论：索引(动词)数据的过程和Query查询的过程都使用了分析器。
    + 为什么必须是相同的分析器？
    + 合并以上全部过程

中部：了解索引(名词)的构成。

- 索引(名词)的构成
- 进一步完善搜索过程：加·入更详细的索引(名词)结构

扩展内容：ES的逻辑结构。

下部：了解排序的简易原理。

- 排序
    + 粗排
        * 文档率：tf(Term Frequent)
        * 逆文档率：idf(Inverse Document Frequent)
    + 精排



## 最简易搜索过程

基于搜索引擎实现，业界比较出名的开源搜索引擎ES(Elasticsearch)，下文简称ES，最简单的搜索过程过程如下：

- 需要被搜索到源数据被索引(动词)到搜索引擎中，并建立索引(名词)
- 用户输入关键词(Query)
- 搜索引擎分析Query并返回数据

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129182415.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129182415.png" style="width:66%">
    </a>
</p>

## 介绍索引(动词)数据的过程

### 简易版本

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183509.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183509.png" style="width:66%">
    </a>
</p>

### 概念解释：倒排索引

### 稍微复杂版本：引入分析器

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183541.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183541.png" style="width:66%">
    </a>
</p>

#### 分析器之字符过滤器

格式化为标准文本(text -> standard text)，例如去掉文本中的html标签

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183701.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183701.png" style="width:60%">
    </a>
</p>

#### 分析器之分词器

文本块拆为独立词条(text -> terms)

自定义词库

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183714.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183714.png" style="width:60%">
    </a>
</p>

#### 分析器之分词过滤器

- 统一转小写
- 同义词
- 近义词转换
- 停用词
- 提取词干
- 纠错
- 自动补全
- 等等...

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129183731.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129183731.png" style="width:60%">
    </a>
</p>

## 介绍用户使用Query查询的过程

### 简易版本

<p align="center">
    <a href="http://cdn.tigerb.cn/20220129185510.png" data-lightbox="roadtrip">
        <img src="http://cdn.tigerb.cn/20220129185510.png" style="width:30%">
    </a>
</p>

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

召回数据之后，你怎么知道docs应该按什么样的顺序排列呢？

相关性 score

- 文档率：tf(Term Frequent)
- 逆文档率：idf(Inverse Document Frequent)


以上是粗排

精排