//
//  SZMineCollectionHeader.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/20.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit
import SnapKit

class SZMineCollectionHeader: UICollectionReusableView {
    
    ///标题
    var titleLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        buildUI()
    }
    // MARK:--创建UI
    func buildUI(){
        titleLabel = UILabel()
        titleLabel.text = "区头"
        titleLabel.textColor = UIColor.init(red: 175/255.0, green: 175/255.0, blue: 175/255.0, alpha: 1.0)
        self.addSubview(titleLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.centerYWithinMargins.equalTo(self.snp.centerYWithinMargins)
            make.height.equalTo(30)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
