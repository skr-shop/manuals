注意是探索两字 

换个角度讲

大家可能以为 我是来讲一个秒杀系统应该怎么做 然而并不主要是

而是 在这这个过程中 

多问为什么 去探索为什么

提出问题 去探索解决问题的思路


理解inode https://www.ruanyifeng.com/blog/2011/12/inode.html


# 业务概念

## 秒杀是什么


做系统概念很重要 尤其是电商系统

![](https://blog-1251019962.cos.ap-beijing.myqcloud.com/qiniu_img_2022/20200712224532.jpeg)
![](https://blog-1251019962.cos.ap-beijing.myqcloud.com/qiniu_img_2022/20200712224556.jpeg)
![](https://blog-1251019962.cos.ap-beijing.myqcloud.com/qiniu_img_2022/20200712224606.jpeg)

```
页面上的电商概念：1. 活动场次 活动的概念、场次的概念 场次是活动的子

页面属性：

1. 活动信息
2. 秒杀商品信息(商品图片、商品名称、商品加车价格、商品售价、其他描述信息)
3. 秒杀进度

```

> 一种营销手段 秒杀是电商的一种营销手段，常见的有一元秒杀

秒杀活动有哪些营销维度

营销维度
- 价格维度
- 数量维度
- 商品维度
- 时间维度

价格维度
- 白菜价
- 非白菜价

数量维度
- 极少(比如几个)
- 非极少

商品维度
- 爆品
- 非爆品

时间维度
- 限时

产生概念
- 白菜价+极少+(爆品或者非爆品)+限时 -> 一元秒杀之类
- 非白菜价+(极少或非极少)+(爆品或者非爆品)+限时 -> 限时购(又称常规秒杀) 
- 非白菜价+(极少或非极少)+爆品+限时 -> 爆品抢购

小米特色 一般 新品=爆品

# 技术栈选型

问题
- 流量带来的高并发问题
- 高并发带来的超售问题

1. 怎么解决瞬时高并发的问题？
2. 怎么解决超售的问题？

用户多 -> 网络链接多


高并发问题
- 多进程 -> php fpm模式
- 多线程 -> java
- 异步 -> node

为什么nginx、redis并发能力强? -> epoll

什么是epoll?

i/o多路复用 网络i/o 以一次读为例

- 等待内核准备数据
- 内核拷贝数到用户态

- 阻塞i/o
- 非阻塞i/o
- i/o多路复用
- 异步i/o

![](https://segmentfault.com/img/bVm1c3)
![](https://segmentfault.com/img/bVm1c4)
![](https://segmentfault.com/img/bVm1c5)
![](https://segmentfault.com/img/bVm1c8)

- `int epoll_create(int size)` 创建一个句柄`int epfd`
- `int epoll_ctl(int epfd, int op, int fd, struct epoll_event* event)` 注册事件 `op 操作，增删改事件` `fd 待监测的链接套接字` `event 事件`
- `int epoll_wait(int eqfd, struct epoll_event* events, int maxevents, int timeout)` 返回已发生的事件们 `events 已发生的事件们`

```c
struct eventpoll {
    ...
    // 红黑树 储存epoll_ctl注册的事件
    // 添加的事件会与与设备驱动程序建立回调关系
    struct rb_root rbr;
    // 双向链表 存储epoll_wait返回已发生的事件们
    // 内核的ep_poll_callback会把发生的事件放在这里
    struct list_head rdllist;
    ...
}
```

https://docs.huihoo.com/doxygen/linux/kernel/3.7/eventpoll_8c_source.html

```
// eventpoll->rbr里每一个事件都对应这个结构
struct epitem {
    ...
  	// 红黑树节点
    struct rb_node rbn;
    // 双向链表
    struct list_head rdllink;
    // 当前epitem指向的文件描述符
    struct epoll_filefd ffd;
    // 指向注册事件时的eventpoll的对象
    struct eventpoll *ep;
    // 当前fd注册的事件
    struct epoll_event event;
    ...
};

// 红黑树节点
struct rb_node
{
	unsigned long  rb_parent_color;
    #define	RB_RED		0
    #define	RB_BLACK	1
	struct rb_node *rb_right;
	struct rb_node *rb_left;
} __attribute__((aligned(sizeof(long))));

// 红黑树根结点
struct rb_root
{
	struct rb_node *rb_node;
};

// 事件epoll_event
struct epoll_event {
  	// 具体的事件 比如读、写等
    __u32 events;
  	// 上下文
    __u64 data;
} EPOLL_PACKED;
```


客户端主动发起 ng被动接受的TCP连接

ngx_connection_t

```list_head
而在linux内核中，list_head链表结构只包含指针域

无论是什么样的指针，它的大小都是一样的，32位的系统中，指针的大小都是32位（即4个字节），只是不同类型的指针在解释的时候不一样而已

偏移量

struct list_head {
    struct list_head *next, *prev;
};
```

```rb_root
Linux内核中红黑树节点的定义如下，其中rb_node是节点类型，而rb_root是仅包含一个节点指针的类，用来表示根节点。

struct rb_node
{
	unsigned long  rb_parent_color;
    #define	RB_RED		0
    #define	RB_BLACK	1
	struct rb_node *rb_right;
	struct rb_node *rb_left;
} __attribute__((aligned(sizeof(long))));

struct rb_root
{
	struct rb_node *rb_node;
};
```



结果：一个进程或线程可以同时处理多个链接，i/o多路复用复用的是进程或者线程

协程 -> go

为什么Go的并发能力强？

GMP

![](https://user-gold-cdn.xitu.io/2019/12/30/16f55033b4edcf10?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

```go
func (srv *Server) Serve(l net.Listener) error {
    ...
    
	ctx := context.WithValue(baseCtx, ServerContextKey, srv)
	for {
		rw, e := l.Accept()
        
        ...

		c := srv.newConn(rw)
		c.setState(c.rwc, StateNew)
		go c.serve(connCtx)
	}
}
```

如何解决超售问题？ -> 并发问题

- 加锁
- 串行化
- 原子操作

原子操作高性能的原因？

轻量，基于CPU指令实现，CAS（Compare-and-Swap），即比较并替换，类似乐观锁

竞争条件是由于异步的访问共享资源，并试图同时读写该资源而导致的，使用互斥锁和通道的思路都是在线程获得到访问权后阻塞其他线程对共享内存的访问，而使用原子操作解决数据竞争问题则是利用了其不可被打断的特性。 https://juejin.im/post/5ee2066fe51d4578455f3caa

结论：Go + epoll + 原子操作

# 业务代码

### 读操作

关于读，我们一般遵循如下优先级：

优先级|技术方案|说明|示例
-------|-------|-------|-------
最高|尽可能静态化|对实时性要去不高的数据，尽可能全走CDN|例如获取基础商品信息
高|就近使用内存|优先级服务器内存、远程内存服务|例如秒杀、抢购库存(优先分配库存到服务器内存，其次远程内存服务<又涉及额外网络IO>)
极低|数据库(能不读就不要读)|连接池、sql优化|常见业务

### 写操作

关于写，我们一般会按照数据的一致性要求级别来看：

数据一致性要求|技术方案
------------|------------
不高|先写内存(优先级从服务器内存到远程内存服务) 再异步储存
高|同步完成最关键的任务 异步保证其他任务最终成功


### 削峰限流

从简单到复杂:

简单程度|技术方案
-------|-------
最简单|百分比流量拒绝
简单|原子操作限流(优先级使用服务器内存、其次远程内存服务)
稍麻烦|漏桶、令牌桶限流
麻烦|队列限流


一个简单的秒杀系统
![](https://blog-1251019962.cos.ap-beijing.myqcloud.com/qiniu_img_2022/20200501175532.png)

一个够用的秒杀系统
![](https://blog-1251019962.cos.ap-beijing.myqcloud.com/qiniu_img_2022/20200501183037.png)

性能再好点的秒杀系统
![](https://blog-1251019962.cos.ap-beijing.myqcloud.com/qiniu_img_2022/20200501200309.png)

支持动态伸缩容的秒杀系统
![](https://blog-1251019962.cos.ap-beijing.myqcloud.com/qiniu_img_2022/20200501200846.png)

公平的秒杀系统
![](https://blog-1251019962.cos.ap-beijing.myqcloud.com/qiniu_img_2022/20200502195413.png)

![](https://blog-1251019962.cos.ap-beijing.myqcloud.com/qiniu_img_2022/20200502200723.png)

```
+------------+
|  秒杀服务   |   
+------------+ 

+------------+
|  购物车服务  |   
+------------+

```