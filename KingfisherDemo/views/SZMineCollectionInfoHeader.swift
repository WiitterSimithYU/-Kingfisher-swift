//
//  SZMineCollectionInfoHeader.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/20.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit
import SnapKit

class SZMineCollectionInfoHeader: UICollectionReusableView {
    
    var bottomView   : UIView!
    var bottomItems  : NSMutableArray!
    var userInfoView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 72/255.0, green: 183/255.0, blue: 159/255.0, alpha: 1.0)
        
        buildUI()
    }
    
    func buildUI(){
        //底部三个按钮
        bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        self.addSubview(bottomView)
        
        
        bottomItems = NSMutableArray()
        let itemTitles = NSArray(objects: "收藏","评价","清单")
        for i in 0..<itemTitles.count {
            let itemView = UIView()
            bottomView.addSubview(itemView)
            
            //图标
            let icon = UIImageView()
            icon.tag = 100
            icon.image = UIImage(named : "Icon_Chat")
            itemView.addSubview(icon)
            //标题
            let title = UILabel()
            title.text = itemTitles[i] as? String
            title.textAlignment = .center
            title.tag = 101
            title.font = UIFont.systemFont(ofSize: 14)
            itemView.addSubview(title)
            
            bottomItems.add(itemView)
        }
        
        //用户信息
        userInfoView = UIView()
        self.addSubview(userInfoView)
        //用户头像
        let userImgView = UIImageView()
        userImgView.image = UIImage(named:"user_headerImg")
        userImgView.tag = 200
        userImgView.clipsToBounds = true
        userImgView.layer.cornerRadius = 20.0
        userInfoView.addSubview(userImgView)
        //用户头像
        let userNameLabel = UILabel()
        userNameLabel.text = "今天天气很好嗯"
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        userNameLabel.textColor = UIColor.white
        userNameLabel.tag = 201
        userInfoView.addSubview(userNameLabel)
        
        //个人信息
        let userLabel = UILabel()
        userLabel.text = "个人信息"
        userLabel.font = UIFont.systemFont(ofSize: 15)
        userLabel.textColor = UIColor.white
        userLabel.tag = 202
        userInfoView.addSubview(userLabel)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(50)
            make.bottom.equalTo(self).offset(0)
        }
        
        var tempView = UIView()
        for i in 0..<bottomItems.count {
            let itemView : UIView! = bottomItems![i] as! UIView
            
            itemView.snp.makeConstraints({ (make) in
                if i==0 {
                    make.left.equalTo(bottomView).offset(0)
                }else{
                    make.left.equalTo(tempView.snp.right).offset(0)
                }
                make.top.equalTo(bottomView).offset(0)
                make.width.equalTo(bottomView.snp.width).dividedBy(3)
                make.height.equalTo(bottomView.snp.height)
            })
            
            tempView = itemView
            
            let icon : UIImageView! = itemView.viewWithTag(100) as! UIImageView
            icon.snp.makeConstraints({ (make) in
                make.width.equalTo(20)
                make.height.equalTo(20)
                make.centerXWithinMargins.equalTo(itemView.snp.centerXWithinMargins)
                make.top.equalTo(itemView).offset(5)
            })
            
            let title : UILabel! = itemView.viewWithTag(101) as! UILabel
            title.snp.makeConstraints({ (make) in
                make.left.equalTo(itemView).offset(0)
                make.right.equalTo(itemView).offset(0)
                make.centerXWithinMargins.equalTo(itemView.snp.centerXWithinMargins)
                make.top.equalTo(icon.snp.bottom).offset(5)
            })
        }
        
        userInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(50)
            make.bottom.equalTo(bottomView.snp.top).offset(-20)
        }
        
        let userImgView : UIImageView! = userInfoView.viewWithTag(200) as! UIImageView
        userImgView.snp.makeConstraints({ (make) in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerYWithinMargins.equalTo(userInfoView.snp.centerYWithinMargins)
            make.left.equalTo(userInfoView).offset(10)
        })
        
        let userNameLabel : UILabel! = userInfoView.viewWithTag(201) as! UILabel
        userNameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(userInfoView).offset(5)
            make.left.equalTo(userImgView.snp.right).offset(10)
            make.right.equalTo(userInfoView).offset(-10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
