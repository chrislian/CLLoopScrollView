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
        self.view.backgroundColor = UIColor ( red: 0.298, green: 0.298, blue: 0.298, alpha: 1.0 )
        
        let image1 = UIImage(named: "image1")!
        let image2 = UIImage(named: "image2")!
        let image3 = UIImage(named: "image3")!
        let image4 = UIImage(named: "image4")!
        let images = [image1,image2,image3,image4]
        
        let loopView = CLLoopView(frame: CGRectMake(0, 22, self.view.frame.size.width, 150))
        self.view.addSubview(loopView)
        loopView.arrImage = images;
        loopView.autoShow = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

