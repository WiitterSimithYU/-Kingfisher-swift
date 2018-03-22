//
//  SZMineCollectionCell.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/20.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit
import SnapKit

class SZMineCollectionCell: UICollectionViewCell {
    ///图标
    var cellIcon : UIImageView!
    ///标题
    var cellTitle: UILabel!
    ///描述
    var cellDes  : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        bulidUI()
        
    }
    /// MARK:--创建ui
    func bulidUI() {
        //1、图标
        cellIcon = UIImageView()
        cellIcon.image = UIImage(named: "icon_wed_gift")
        self.contentView.addSubview(cellIcon)
        
        //2、标题
        cellTitle = UILabel()
        cellTitle.font = UIFont.systemFont(ofSize: 15)
//        cellTitle.backgroundColor = UIColor.yellow
        cellTitle.textAlignment = .center
        cellTitle.text = "我的钱包"
        cellTitle.textColor = UIColor.init(red: 68/255.0, green: 68/255.0, blue: 68/255.0, alpha: 1.0)
        self.contentView.addSubview(cellTitle)
        
        //3、描述
        cellDes = UILabel()
        cellDes.font = UIFont.systemFont(ofSize: 14)
//        cellDes.backgroundColor = UIColor.green
        cellDes.textAlignment = .center
        cellDes.text = "办信用卡"
        cellDes.textColor = UIColor.init(red: 175/255.0, green: 175/255.0, blue: 175/255.0, alpha: 1.0)
        self.contentView.addSubview(cellDes)
    }
    
    /// MARK:--重新布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellIcon.snp.makeConstraints { (make) in
            make.centerXWithinMargins.equalTo(self.contentView.snp.centerXWithinMargins)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(self.contentView).offset(10)
        }
        
        cellTitle.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.equalTo(self.contentView).offset(0)
            make.right.equalTo(self.contentView).offset(0)
            make.top.equalTo(cellIcon.snp.bottom).offset(10)
        }
        
        cellDes.snp.makeConstraints { (make) in
            make.height.equalTo(15)
            make.left.equalTo(self.contentView).offset(0)
            make.right.equalTo(self.contentView).offset(0)
            make.top.equalTo(cellTitle.snp.bottom).offset(0)
        }
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
