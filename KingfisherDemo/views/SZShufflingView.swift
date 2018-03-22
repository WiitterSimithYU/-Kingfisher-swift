//
//  SZShufflingView.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/15.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit
import Kingfisher

let screenWidth:CGFloat  = UIScreen.main.bounds.size.width
let screenHeight:CGFloat = UIScreen.main.bounds.size.height

//点击imgView的回调
typealias imgCallBack = (_ index : Int) -> ()

public enum UIPageControlShowStyle : Int {
    case none     // default
    case left
    case center
    case right
}

class SZShufflingView: UIView ,UIScrollViewDelegate{
     var moveTimer : Timer!
     var shufflingScrollView : UIScrollView!
     var pageControl : UIPageControl!
     var pageStyle   : UIPageControlShowStyle! //设置pageControl显示位置
     var placeholderImage : UIImage! //占位符
     var shufflingMoveTime :TimeInterval! = 2
     var linkImgUrls   : NSMutableArray!
     var leftImgView : UIImageView!
     var centerImgView : UIImageView!
     var rightImgView : UIImageView!
     var leftImgIndex : Int = 0
     var centerImgIndex : Int = 0
     var rightImgIndex : Int = 0
     var isTimeUp : Bool = false
     var isNeedCycleRoll : Bool = false
     var imgTapCallBack :imgCallBack!
    
    /// 设置轮播图
    /// Parameter: frame 字体
    /// Parameter: linkUrls 计算文本
    /// Parameter: pageStyle pageControl的样式
    /// Return:    SZShufflingView 轮播图
    static func setShufflingViewWithFrame(frame : CGRect, imageLinkURL linkUrls : NSArray,pageControlShowStyle pageStyle:UIPageControlShowStyle)->SZShufflingView{
        let shufflingView = SZShufflingView(frame: frame)
        shufflingView.loadData(linkUrls: linkUrls)
        shufflingView.bulidUI()
        shufflingView.realodShufflingViewData()
        return shufflingView;
    }
    open  func loadData(linkUrls : NSArray){
        linkImgUrls = NSMutableArray()
        linkImgUrls.addObjects(from: linkUrls as! [Any])
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        isNeedCycleRoll = true
    }
    // MARK:--刷新数据
    func realodShufflingViewData(){
        leftImgIndex = linkImgUrls.count - 1;
        centerImgIndex = 0;
        rightImgIndex = 1;
        
        
        leftImgView.kf.setImage(with: URL(string:(linkImgUrls[leftImgIndex] as? String)!), placeholder: UIImage(named: "img_plocher"), options: KingfisherOptionsInfo?.none, progressBlock: nil, completionHandler: nil)
        centerImgView.kf.setImage(with: URL(string:(linkImgUrls[centerImgIndex] as? String)!), placeholder: UIImage(named: "img_plocher"), options: KingfisherOptionsInfo?.none, progressBlock: nil, completionHandler: nil)
        rightImgView.kf.setImage(with: URL(string:(linkImgUrls[rightImgIndex] as? String)!), placeholder: UIImage(named: "img_plocher"), options: KingfisherOptionsInfo?.none, progressBlock: nil, completionHandler: nil)
        
    }
    // MRAK:--创建UI
    func bulidUI(){
        shufflingScrollView = UIScrollView(frame: self.bounds)
        shufflingScrollView.bounces = false
        shufflingScrollView.showsHorizontalScrollIndicator = false;
        shufflingScrollView.showsVerticalScrollIndicator = false;
        shufflingScrollView.isPagingEnabled = true;
        shufflingScrollView.contentOffset = CGPoint(x:screenWidth, y:0);
        shufflingScrollView.contentSize = CGSize(width:screenWidth * CGFloat(3), height:100);
        shufflingScrollView.delegate = self
        //该句是否执行会影响pageControl的位置,如果该应用上面有导航栏,就是用该句,否则注释掉即可
        shufflingScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        leftImgView = UIImageView(frame: CGRect(x:0,y:0,width:screenWidth,height:100))
        leftImgView.backgroundColor = UIColor.green
        shufflingScrollView.addSubview(leftImgView)
        
        centerImgView = UIImageView(frame: CGRect(x:screenWidth,y:0,width:screenWidth,height:100))
        centerImgView.isUserInteractionEnabled = true
        centerImgView.backgroundColor = UIColor.blue
        shufflingScrollView.addSubview(centerImgView)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapGesAction))
        
        centerImgView.addGestureRecognizer(tapGes)
        
        rightImgView = UIImageView(frame: CGRect(x:screenWidth*CGFloat(2),y:0,width:screenWidth,height:100))
        rightImgView.backgroundColor = UIColor.red
        shufflingScrollView.addSubview(rightImgView)
        
        self.addSubview(shufflingScrollView)
        
        //页码器
        pageControl = UIPageControl()
        pageControl.numberOfPages = linkImgUrls.count
        pageControl.frame = CGRect(x:0,y:self.frame.size.height-20,width:self.frame.maxX,height:20)
        pageControl.backgroundColor = UIColor.clear
        pageControl.isEnabled = false
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.black
        self.addSubview(pageControl)
        

        
    }
    @objc func tapGesAction(){
        print("tapGes")
        imgTapCallBack(10)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 这个方法会在子视图添加到父视图或者离开父视图时调用
    override func willMove(toSuperview newSuperview: UIView?) {
        //解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
        if newSuperview==nil {
            
            moveTimer.invalidate()
            self.moveTimer = nil;
        }
        else
        {
            startMoveTimer()
        }
    }
    // MARK:--开始移动定时器
    func startMoveTimer() {
        if isNeedCycleRoll==true {
              moveTimer = Timer.scheduledTimer(timeInterval: shufflingMoveTime, target: self, selector: #selector(moveAction(time:)), userInfo: nil, repeats: true)
             isTimeUp = false
        }else{
            
        }
      
    }
    // MARK:--开始移动
    @objc func moveAction(time : Timer){
        shufflingScrollView.setContentOffset(CGPoint(x:screenWidth * CGFloat(2),y:0), animated: true)
        isTimeUp = true
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(scrollViewDidEndDecelerating(_:)), userInfo: nil, repeats: false)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if shufflingScrollView.contentOffset.x == CGFloat(0) {
            centerImgIndex = centerImgIndex - 1
            leftImgIndex = leftImgIndex - 1
            rightImgIndex = rightImgIndex - 1
            
            if leftImgIndex == -1 {
                leftImgIndex = linkImgUrls.count-1
            }
            if centerImgIndex == -1 {
                centerImgIndex = linkImgUrls.count-1
            }
            if rightImgIndex == -1 {
                rightImgIndex = linkImgUrls.count-1
            }
            
        }else if shufflingScrollView.contentOffset.x == (screenWidth * CGFloat(2)) {
            centerImgIndex = centerImgIndex + 1
            leftImgIndex = leftImgIndex + 1
            rightImgIndex = rightImgIndex + 1
            
            if leftImgIndex == linkImgUrls.count {
                leftImgIndex = 0
            }
            if centerImgIndex == linkImgUrls.count {
                centerImgIndex = 0
            }
            if rightImgIndex == linkImgUrls.count {
                rightImgIndex = 0
            }
            
        }else {
            return
        }
        leftImgView.kf.setImage(with: URL(string:(linkImgUrls[leftImgIndex] as? String)!), placeholder: UIImage(named: "img_plocher"), options: KingfisherOptionsInfo?.none, progressBlock: nil, completionHandler: nil)
        centerImgView.kf.setImage(with: URL(string:(linkImgUrls[centerImgIndex] as? String)!), placeholder: UIImage(named: "img_plocher"), options: KingfisherOptionsInfo?.none, progressBlock: nil, completionHandler: nil)
        rightImgView.kf.setImage(with: URL(string:(linkImgUrls[rightImgIndex] as? String)!), placeholder: UIImage(named: "img_plocher"), options: KingfisherOptionsInfo?.none, progressBlock: nil, completionHandler: nil)
        //重制 index
        pageControl.currentPage = centerImgIndex

        shufflingScrollView.setContentOffset(CGPoint(x:screenWidth ,y:0), animated: false)
        
        //手动控制图片滚动应该取消那个三秒的计时器
        if isTimeUp == false {
            moveTimer.fireDate = Date(timeIntervalSinceNow: shufflingMoveTime)
        }
        isTimeUp = false
        

        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        moveTimer.invalidate()
        self.moveTimer = nil;
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startMoveTimer()
    }

}
