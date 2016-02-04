//
//  CLLoopView.swift
//  CLLoopScrollView
//
//  Created by Chris on 16/1/4.
//  Copyright © 2016年 ChrisLian. All rights reserved.
//

import UIKit

public protocol CLLoopViewDelegate{
    func selectLoopViewPage(idx:Int);
}

public class CLLoopView: UIView,UIScrollViewDelegate {
    
    /**
     初始化
     
     - returns:
     */
    private func initializeUI(){
        
        let width = self.frame.size.width;
        let height = self.frame.size.height;
        
        loopScrollView.frame = CGRectMake(0,0,width,height)
        loopScrollView.contentSize = CGSizeMake(width * 3.0,height)
        loopScrollView.showsVerticalScrollIndicator = false
        loopScrollView.showsHorizontalScrollIndicator = false
        loopScrollView.delegate = self
        loopScrollView.bounces = false
        self.addSubview(loopScrollView)
        
        pageControl.frame = CGRectMake(0,height - 20,width,20)
        pageControl.userInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor ( red: 0.0, green: 0.502, blue: 1.0, alpha: 1.0 )
        pageControl.pageIndicatorTintColor = UIColor ( red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0 )
        self.addSubview(pageControl)
        
        let tap = UITapGestureRecognizer(target: self, action: "tapGestureHandle:")
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        loopScrollView.addGestureRecognizer(tap)
        
        
        imageView0.frame = CGRect(x: 0, y: 0, width: width, height: height)
        imageView1.frame = CGRect(x: width, y: 0, width: width, height: height)
        imageView2.frame = CGRect(x: width * 2.0, y: 0, width: width, height: height)
        loopScrollView.addSubview(imageView0)
        loopScrollView.addSubview(imageView1)
        loopScrollView.addSubview(imageView2)
    }
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        self.stopTimer()
    }
    
    //MARK: - UIScrollView delegate
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let ratio = scrollView.contentOffset.x/self.frame.size.width
        self.endScrollMethod(ratio)
    }
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            let ratio = scrollView.contentOffset.x/self.frame.size.width
            self.endScrollMethod(ratio)
        }
    }
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.stopTimer()
    }
    
    //MARK: - reload data
    private func updateImageData(){
        
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
    //
    private func endScrollMethod(ratio:CGFloat){
        
        if ratio <= 0.7{
            if currentPage - 1 < 0{
                currentPage = arrImage.count - 1
            }else{
                currentPage -= 1
            }
        }
        if ratio >= 1.3{
            if currentPage == arrImage.count - 1{
                currentPage = 0
            }else{
                currentPage += 1
            }
        }
        
        self.updateImageData()
        self.startTimer()
    }
    
    private func startTimer(){
        if autoShow{
            timer = nil
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "autoTurnNextView", userInfo: nil, repeats: true)
        }
    }
    private func stopTimer(){
        if autoShow{
            guard let timer = self.timer else{
                return
            }
            if timer.valid{
                timer.invalidate()
            }
        }
    }
    
    
    //MARK: event response
    @objc private func tapGestureHandle(tap:UITapGestureRecognizer){
        guard let tmp = delegate else{
            print("delegate is nil")
            return
        }
        tmp.selectLoopViewPage(currentPage)
    }
    @objc private func autoTurnNextView(){
        
        if currentPage == arrImage.count - 1{
            currentPage = 0
        }else{
            currentPage += 1
        }
        self.updateImageData()
    }
    
    //MARK: - setter & getter
    private var timer:NSTimer?       = nil
    public var delegate:CLLoopViewDelegate? = nil
    public var currentPage:Int = 0
    /// 定时跳转到下一页
    var timeInterval:NSTimeInterval = 3{
        willSet{
            if autoShow{
                self.stopTimer()
            }
        }
        didSet{
            if autoShow{
                self.startTimer()
            }
        }
    }
    //是否定时跳转到下一页
    public var autoShow:Bool = false{
        didSet{
            if autoShow{
                self.startTimer()
            }else{
                self.stopTimer()
            }
        }
    }
    //图片数组
    public var arrImage:[UIImage] = []{
        willSet{
            currentPage = 0
            pageControl.numberOfPages = newValue.count
        }
        didSet{
            self.updateImageData()
        }
    }
    
    private let pageControl:UIPageControl   = UIPageControl()
    private let loopScrollView:UIScrollView = UIScrollView()
    
    private let imageView0:UIImageView = UIImageView()
    private let imageView1:UIImageView = UIImageView()
    private let imageView2:UIImageView = UIImageView()

}
