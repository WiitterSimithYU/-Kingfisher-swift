//
//  RootVC.swift
//  KingfisherDemo
//
//  Created by 沈震 on 2017/11/14.
//  Copyright © 2017年 shenzhen. All rights reserved.
//

import UIKit

class RootVC: UITableViewController {
    
    var lists : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = []
        
        
        
        
        self.title = "目录"
        self.view.backgroundColor = UIColor.white
        self.lists = NSMutableArray()
        for i in 0..<20 {
            if i==0 {
               self.lists.add("Kingfisher使用")
            }else if i==1{
                self.lists.add("uicollectionView使用")
            }
            else {
               self.lists.add("weather")
            }
            
        }
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "list")
        

        self.tableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)
//        if cell==nil {
//            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "reuseIdentifier")
//        }
        cell.textLabel?.text = self.lists[indexPath.row] as? String;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = SZKingFisherDemoVC()
            
            self.navigationController?.pushViewController(vc, animated: true)
            break
            //模仿美团我的
        case 1:
            let vc =  MineVC()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default: break
            
        }
        
        
    }
    
    
   
    
    
}
