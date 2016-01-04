//
//  CLLoopView.swift
//  CLLoopScrollView
//
//  Created by Chris on 16/1/4.
//  Copyright © 2016年 ChrisLian. All rights reserved.
//

import UIKit

class CLLoopView: UIView,UIScrollViewDelegate {

    //MARK: life cycle
    deinit{
        self.stopTimer()
    }
    
    //MARK: UIScrollView delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let ratio = scrollView.contentOffset.x/self.frame.size.width
        self.endScrollMethod(ratio)
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            let ratio = scrollView.contentOffset.x/self.frame.size.width
            self.endScrollMethod(ratio)
        }
    }
    
    //MARK: reload data
    func reloadImageData(){
        let array = self.loopScrollView.subviews
        for view in array{
            view.removeFromSuperview()
        }
        let imageView0:UIImageView = {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.loopScrollView.addSubview(imageView)
            return imageView
        }()
        let imageView1:UIImageView = {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.loopScrollView.addSubview(imageView)
            return imageView
        }()
        let imageView2:UIImageView = {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: self.frame.size.width * 2.0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.loopScrollView.addSubview(imageView)
            return imageView
        }()
        
        if currentPage == 0{
            imageView0.image = arrImage.last
            imageView1.image = arrImage[currentPage]
            imageView2.image = arrImage[currentPage + 1]
        }else if currentPage == arrImage.count - 1{
            imageView0.image = arrImage[currentPage - 1]
            imageView1.image = arrImage[currentPage]
            imageView2.image = arrImage.first
        }else{
            imageView0.image = arrImage[currentPage - 1]
            imageView1.image = arrImage[currentPage]
            imageView2.image = arrImage[currentPage + 1]
        }
        pageControl.currentPage = currentPage
        loopScrollView.contentOffset = CGPoint(x: self.frame.size.width,y: 0)

    }
    
    func endScrollMethod(ratio:CGFloat){
        
        if ratio <= 0.8{
            if currentPage - 1 < 0{
                currentPage = arrImage.count - 1
            }else{
                currentPage -= 1
            }
        }
        if ratio >= 1.2{
            if currentPage == arrImage.count - 1{
                currentPage = 0
            }else{
                currentPage += 1
            }
        }
        
        self.reloadImageData()
    }
    
    //MARK: event response
    @objc private func tapGestureHandle(tap:UITapGestureRecognizer){
        //todo
    }
    private func autoTurnNextView(){
        
        if currentPage == arrImage.count - 1{
            currentPage = 0
        }else{
            currentPage += 1
        }
    }
    
    private func startTimer(){
        timer = nil
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "autoTurnNextView", userInfo: nil, repeats: true)
    }
    private func stopTimer(){
        guard let timer = self.timer else{
            return
        }
        if timer.valid{
            timer.invalidate()
        }
    }
    
    //MARK: setter & getter
    var timer:NSTimer? = nil
    var currentPage:Int = 0
    
    var autoShow:Bool = false{
        willSet{
            if newValue{
                self.startTimer()
            }else{
                self.stopTimer()
            }
        }
    }
    var arrImage:[UIImage] = []{
        willSet{
            currentPage = 0
            pageControl.numberOfPages = newValue.count
        }
        didSet{
            self.reloadImageData()
        }
    }
    
    lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.frame = CGRectMake(0,self.frame.size.height - 20,self.frame.size.width,20)
        pageControl.userInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor ( red: 0.298, green: 0.298, blue: 0.298, alpha: 1.0 )
        pageControl.pageIndicatorTintColor = UIColor ( red: 0.902, green: 0.902, blue: 0.902, alpha: 1.0 )
        self.addSubview(pageControl)
        return pageControl
    }()
    
    lazy var loopScrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height)
        scrollView.contentSize = CGSizeMake(self.frame.size.width * 3.0,self.frame.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        self.addSubview(scrollView)
        return scrollView
    }()
    
    lazy var tagGestrue:UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: "tapGestureHandle:")
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        return tap
    }()
}
