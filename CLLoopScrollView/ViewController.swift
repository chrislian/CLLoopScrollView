//
//  ViewController.swift
//  CLLoopScrollView
//
//  Created by Chris on 16/1/4.
//  Copyright © 2016年 ChrisLian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        let view:UIView = {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 22, width: self.view.frame.size.width, height: 150)
            self.view.addSubview(view)
            view.backgroundColor = UIColor.whiteColor()
            return view
        }()
        
        let image1 = UIImage(named: "image1")!
        let image2 = UIImage(named: "image2")!
        let image3 = UIImage(named: "image3")!
        let images = [image1,image2,image3]
        
        let loopView = CLLoopView()
        view.addSubview(loopView)
        loopView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
        loopView.arrImage = images;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

