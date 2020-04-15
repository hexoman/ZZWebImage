# ZZWebImage
### 一个在线图片异步加载并缓存的轮子
- [x] 支持在线加载
- [x] 支持内存缓存和磁盘缓存
- [x] 支持控件扩展

### 用法

``` swift
let url = "http://example.png"
imageView.setImage(url)
```

``` swift
let url = "http://example.png"
imageView.setImage(url, placeholder: UIImage.init(named: "test.png"))
```

