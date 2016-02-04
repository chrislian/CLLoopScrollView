# CLRollingCycleView
>首页循环滚动播放图片

![imageView](https://github.com/chrislian/CLLoopScrollView/blob/master/clloopscrollview.gif)

##安装
### CocoaPods 
1. 在`Podfile`导入 `pod 'CLLoopScrollView', '~> 0.0.1'`
2. 执行 `pod install` or `pod update`

###手动安装
1. 下载**CLRollingCycleView**工程下的**Classes**文件的内容
2. 将`CLLoopView/Classes`文件拖拽到项目中

##使用方法

```
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image1 = UIImage(named: "Barcelona0")!
        let image2 = UIImage(named: "Barcelona1")!
        let image3 = UIImage(named: "Barcelona2")!
        let image4 = UIImage(named: "Barcelona3")!
        let images = [image1,image2,image3,image4]
        
        let rect = CGRectMake(0, 22, self.view.frame.size.width, self.view.frame.size.width/16 * 9)
        let loopView = CLLoopView(frame: rect)
        self.view.addSubview(loopView)
       	loopView.arrImage = images;
        loopView.autoShow = true
        loopView.delegate = self
    }
```

##系统要求
最低支持iOS8.0
##LICENSE
CLRollingCycleView使用MIT license,详情请见 LICENSE文件



