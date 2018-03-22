//
//  SZMineCollectionModel.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/20.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit

class SZMineCollectionModel: NSObject {
    var itemIconName : String!
    var itemTitle : String!
    var itemDes   : String!
    
  
    
    open func setData(dict : NSDictionary){
        itemIconName = dict["itemIconName"] as! String
        itemTitle = dict["itemTitle"] as! String
        itemDes = dict["itemDes"] as! String
    }
    

}
