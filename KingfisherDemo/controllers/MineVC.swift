//
//  MineVC.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/20.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit

class MineVC: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SZMineCustomNavBarViewDelegate{
    var collectionView : UICollectionView!
    let headerID : String  = "mineHeaderID"
    let infoHeaderID : String = "infoHeaderID"
    let footerID : String  = "mineFooterID"
    let collectionID : String = "mineCollectionID"
    var myAssetLists : NSMutableArray!
    var mtServiceLists : NSMutableArray!
    var navBarView     : SZMineCustomNavBarView!
    let magin : CGFloat = 1.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        
        initData()
        buildUI()
        
    }
    // MARK:--初始化数据
    func initData(){
        let dict : Dictionary<String,AnyObject>?  = SZTools.readJSONData(jsonName: "mineItems") as? Dictionary<String,AnyObject>
        myAssetLists = NSMutableArray()
        mtServiceLists = NSMutableArray()
        
        //我的资产
        let assets : NSArray! = dict!["assets"] as! NSArray
        //美团服务
        let services : NSArray! = dict!["services"] as! NSArray
        
        for i  in 0..<assets.count {
            let model  = SZMineCollectionModel()
            model.setData(dict: assets[i]  as! NSDictionary)
            myAssetLists.add(model)
        }
        for i  in 0..<services.count {
            let model  = SZMineCollectionModel()
            model.setData(dict: services[i]  as! NSDictionary)
            mtServiceLists.add(model)
        }
        
    }
    // MARK:--创建ui
    func buildUI(){
        
        //设置layout
        let layout  =  UICollectionViewFlowLayout()
        layout.footerReferenceSize = CGSize(width:screenWidth,height:20)
        layout.minimumLineSpacing = magin
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x:0,y:0,width:screenWidth,height:screenHeight), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.init(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
        self.view.addSubview(collectionView)
        
        collectionView.register(SZMineCollectionCell.self, forCellWithReuseIdentifier: collectionID)
        collectionView.register(SZMineCollectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerID)
        

         collectionView.register(SZMineCollectionInfoHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: infoHeaderID)
        
        collectionView.alwaysBounceVertical = true
        
        
        //navView
        navBarView = SZMineCustomNavBarView(frame: CGRect(x:0,y:0,width:screenWidth,height:64.0))
        navBarView.delegate = self
        self.view.addSubview(navBarView)
        
        
        let bgView = UIView(frame: CGRect(x:0,y:-300,width:screenWidth,height:300.0))
        bgView.backgroundColor = UIColor.init(red: 72/255.0, green: 183/255.0, blue: 159/255.0, alpha: 1.0)
        collectionView.addSubview(bgView)
        
//        //设置 刷新
//        let refreshControl = UIRefreshControl()
//        refreshControl.tintColor = UIColor.lightGray
//        refreshControl.attributedTitle = NSAttributedString.init(string: "下拉刷新")
//        refreshControl.addTarget(self, action: #selector(pullRefresh), for: UIControlEvents.valueChanged)
//
//        collectionView.refreshControl = refreshControl
        
        
      
        
        
    }
    // MARK:--SZMineCustomNavBarViewDelegate 导航点击事件
    func itemAction(navView : SZMineCustomNavBarView, withItemIndex index : NSInteger){
        switch index {
        case 0:
            print("1、提醒按钮")
            break
        case 1:
            print("2、设置按钮")
            break
        case 2:
            print("3、换肤按钮")
            break
        default: break
            
        }
    }
    ///下拉刷新
    @objc func pullRefresh(){
        let time : TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            self.collectionView.refreshControl?.endRefreshing()
        }
        
        
    }
    // MARK:--UICollectionView delegate and dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section==0 {
            return 0
        }
        else if section==1 {
            return myAssetLists.count
        }else{
            return mtServiceLists.count
        }
    }
    // TODO:--设置区头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if kind==UICollectionElementKindSectionHeader {
            
            if indexPath.section==0 {
                var headerView = SZMineCollectionInfoHeader()
                headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: infoHeaderID, for: indexPath) as! SZMineCollectionInfoHeader
                return headerView
            }else{
                var headerView = SZMineCollectionHeader(frame: CGRect(x:0,y:0,width:screenWidth,height:50))
                headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! SZMineCollectionHeader
                if indexPath.section==1 {
                    headerView.titleLabel.text = "我的资产"
                }else{
                    headerView.titleLabel.text = "美团服务"
                }
                
                return headerView
            }
            
        }else{
            var footerView = UICollectionReusableView()
            footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath)
            return footerView
        }
        
    }
    //设置区头高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if section==0 {
            return CGSize(width:screenWidth,height:190)
        }else{
            return CGSize(width:screenWidth,height:50)
        }
    }
    //设置cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let w : CGFloat = (screenWidth  - magin*CGFloat(4) )/4.0
        return CGSize(width:w,height:w)
    }
    //设置间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(magin, magin, magin, magin)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SZMineCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionID, for: indexPath) as! SZMineCollectionCell
        

        if indexPath.section==0 {
            
            let model  = myAssetLists[indexPath.row] as! SZMineCollectionModel
             cell.cellTitle.text = model.itemTitle
             cell.cellDes.text = model.itemDes
            
        }else{
            let model  = mtServiceLists[indexPath.row] as! SZMineCollectionModel
            cell.cellTitle.text = model.itemTitle
            cell.cellDes.text = model.itemDes
        }
        return cell
    }

    // MARK:--设置导航
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY : CGFloat = scrollView.contentOffset.y
        
        if offsetY<64 {
            navBarView.backgroundColor = UIColor.clear
        }else{
            navBarView.backgroundColor = UIColor.init(red: 72/255.0, green: 183/255.0, blue: 159/255.0, alpha: 1.0)
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
