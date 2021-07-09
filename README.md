# FloatView_swift
浮动图片

## iOS 技术交流
我创建了一个 微信 iOS 技术交流群，欢迎小伙伴们加入一起交流学习~
	
可以加我微信我拉你进去（备注iOS），我的微信号 wr1204607318

### Objective-C实现地址
https://github.com/wangrui460/FloatView

### 使用方式
<pre><code>
override func viewDidLoad()
{
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    // 创建方式一：
    let floatView = FloatView(image: UIImage(named: "FloatBonus"))

    // 创建方式二：
    let floatView = FloatView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    floatView.image = UIImage(named: "FloatBonus")
    
    view.addSubview(floatView)
}
</code></pre>

### 联系我
扫码回复1获取面试资料（持续更新）
![](https://user-images.githubusercontent.com/11909313/123933944-6a4abe00-d9c5-11eb-83ca-379313a2af7c.png)
