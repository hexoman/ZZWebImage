# ZZWebImage
### 一个swift写的在线图片异步加载并缓存的轮子

iOS图片异步加载框架首推onevcat的[Kingfisher](https://github.com/onevcat/Kingfisher)。该项目目前只是初步实现了并发加载和缓存、过期失效等基础功能。

- [x] 支持在线加载
- [x] 支持内存缓存和磁盘缓存
- [x] 支持过期图片失效

### 用法

``` swift
let url = "http://example.png"
imageView.setImage(url)
```

``` swift
let url = "http://example.png"
imageView.setImage(url, placeholder: UIImage.init(named: "test.png"))
```

### 待完成...
- [x]支持jpg、gif、webp等图片格式
- [x]imageView扩展增加loading状态
- [x]支持取消正在进行的下载任务
- [x]支持下载的图片自适应view的size

