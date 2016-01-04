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
        let images = [image1,image2,image3]
        
        let loopView = CLLoopView()
        self.view.addSubview(loopView)
        loopView.frame = CGRectMake(0, 22, self.view.frame.size.width, 150)
        loopView.arrImage = images;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

