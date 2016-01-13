//
//  ViewController.swift
//  CLLoopScrollView
//
//  Created by Chris on 16/1/4.
//  Copyright © 2016年 ChrisLian. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CLLoopViewDelegate {

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor ( red: 0.902, green: 0.902, blue: 0.902, alpha: 1.0 )
        
        let image1 = UIImage(named: "Barcelona0")!
        let image2 = UIImage(named: "Barcelona1")!
        let image3 = UIImage(named: "Barcelona2")!
        let image4 = UIImage(named: "Barcelona3")!
        let images = [image1,image2,image3,image4]
        
        let loopView = CLLoopView(frame: CGRectMake(0, 22, self.view.frame.size.width, self.view.frame.size.width/16 * 9))
        self.view.addSubview(loopView)
        //更新图片数组
        loopView.arrImage = images;
        //开启自动翻页
        loopView.autoShow = true
        //代理
        loopView.delegate = self
    }

    //MARK: - CLLoopView Delegate
    func selectLoopViewPage(idx: Int) {
        print("select page:\(idx)")
    }
}

