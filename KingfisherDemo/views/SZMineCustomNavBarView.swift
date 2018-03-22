//
//  SZMineCustomNavBarView.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/21.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol SZMineCustomNavBarViewDelegate : NSObjectProtocol {
    
    ///按钮的点击事件
    func itemAction(navView : SZMineCustomNavBarView, withItemIndex index : NSInteger)
    
}


class SZMineCustomNavBarView: UIView {
    let viewH : CGFloat = 64.0
    ///提醒按钮
    var remindItem  : UIButton!
    ///设置按钮
    var settingItem : UIButton!
    ///换肤按钮
    var styleItem   : UIButton!
    var delegate    : SZMineCustomNavBarViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.init(red: 72/255.0, green: 183/255.0, blue: 159/255.0, alpha: 1.0)
        
        self.backgroundColor = UIColor.clear
        
        buildUI()
        
    }
    /// 创建UI
    func buildUI(){
        //1、提醒按钮
        remindItem = UIButton(type: .custom)
//        remindItem.backgroundColor = UIColor.white
        remindItem.setImage(UIImage(named:"icon_navigationItem_message_white"), for: UIControlState.normal)
        remindItem.tag = 0
        remindItem.addTarget(self, action: #selector(itemAction(item:)), for: UIControlEvents.touchUpInside)
        self.addSubview(remindItem)
        
        //2、设置按钮
        settingItem = UIButton(type: .custom)
        settingItem.setImage(UIImage(named:"icon_navigationItem_set_white"), for: UIControlState.normal)
        settingItem.tag = 1
        settingItem.addTarget(self, action: #selector(itemAction(item:)), for: UIControlEvents.touchUpInside)
        self.addSubview(settingItem)
        
        //3、换肤按钮
        styleItem = UIButton(type: .custom)
        styleItem.tag = 2
        styleItem.addTarget(self, action: #selector(itemAction(item:)), for: UIControlEvents.touchUpInside)
        styleItem.setImage(UIImage(named:"icon_navigationItem_share_white"), for: UIControlState.normal)
        self.addSubview(styleItem)
    }
    
    // MARK:--按钮的点击事件
    @objc func itemAction(item : UIButton){
        let result = delegate.responds(to: #selector(delegate.itemAction(navView:withItemIndex:)))
        
        if result==true {
            delegate.itemAction(navView: self, withItemIndex: item.tag)
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        remindItem.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.width.equalTo(40)
            make.height.equalTo(44)
            make.top.equalTo(self).offset(20)
        }
        settingItem.snp.makeConstraints { (make) in
            make.right.equalTo(remindItem.snp.left).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(44)
            make.top.equalTo(self).offset(20)
        }
        styleItem.snp.makeConstraints { (make) in
            make.right.equalTo(settingItem.snp.left).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(44)
            make.top.equalTo(self).offset(20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
