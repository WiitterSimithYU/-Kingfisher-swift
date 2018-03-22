//
//  SZKingFisherDemoVC.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/15.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit


class SZKingFisherDemoVC: UIViewController {

    var imgView1 : UIImageView!
    
    
    open static func showInTable(){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       title = "Kingfisher的使用"
       view.backgroundColor = UIColor.white
    
        
       self.edgesForExtendedLayout = []
        
        
        bulidImgView1()
        
        
        bulidImgView2()
        
    }
    
    // MARK:--imgView1
    func bulidImgView1(){
        let ImgView = UIImageView()
        ImgView.backgroundColor = UIColor.green
        self.view.addSubview(ImgView)
        ImgView.snp.makeConstraints { (make) in
//              make.left.equalTo(self.view).offset(50)
//              make.right.equalTo(self.view).offset(-50)
              make.top.equalTo(self.view).offset(10)
              make.centerXWithinMargins.equalTo(self.view.snp.centerXWithinMargins)
              make.width.equalTo(90)
              make.height.equalTo(90)
        }
        imgView1 = ImgView
        
        
        
        imgView1.kf.setImage(with: URL(string: "http://image.xmcdn.com/group34/M02/57/70/wKgJYFntj2XAXnTqAAc4IazdPvc628.jpg?op_type=9&magick=jpg&strip=1&quality=6"), placeholder: UIImage(named: "img_plocher"), options: KingfisherOptionsInfo?.none, progressBlock: nil, completionHandler: nil)
    }
    
    func bulidImgView2(){
        let url1 : String = "https://dimg04.c-ctrip.com/images/300w0m000000do9sa7609.jpg"
        let url2 : String = "http://image.xmcdn.com/group32/M03/42/C6/wKgJnFmaOzKyNiNIAAJ4FyNRNF8538.jpg?op_type=9&magick=jpg&strip=1&quality=6"
        let url3 : String = "http://image.xmcdn.com/group34/M02/57/70/wKgJYFntj2XAXnTqAAc4IazdPvc628.jpg?op_type=9&magick=jpg&strip=1&quality=6"
        let url4 : String = "http://image.xmcdn.com/group34/M08/A7/5F/wKgJYFnm-1nhmj7VAAFK_ktwsyQ017.jpg?op_type=9&magick=jpg&strip=1&quality=6"
        
        let list = NSArray(objects: url1,url2,url3,url4)
        
        let view2 = SZShufflingView.setShufflingViewWithFrame(frame: CGRect(x:0,y:120,width:screenWidth,height:100), imageLinkURL:list, pageControlShowStyle: UIPageControlShowStyle.none)
        self.view.addSubview(view2)
        
        view2.imgTapCallBack = {
            (index : Int) in
            print(index)
        }
        
        
        
      
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
