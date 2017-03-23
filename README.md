# FloatView_swift
浮动图片

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
