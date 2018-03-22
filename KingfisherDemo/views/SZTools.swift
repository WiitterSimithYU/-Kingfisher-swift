//
//  SZTools.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/20.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit

class SZTools: NSObject {
    
    /// 读取本地json 数据
   open static func readJSONData(jsonName : String) ->NSDictionary?{
        let path : String =  Bundle.main.path(forResource: jsonName, ofType: "json")!
        do{
            let  jsonStr : String! = try String.init(contentsOfFile: path)
            let jsonData : Data! = jsonStr.data(using: String.Encoding.utf8)
            let response : NSDictionary?
            response = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
            return response
        }catch{
            return nil
        }
    }

}
