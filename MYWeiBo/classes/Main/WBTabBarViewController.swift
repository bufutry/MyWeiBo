//
//  WBTabBarViewController.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/11.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class WBTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        tabBar.tintColor = UIColor.orangeColor()
        addChildViewController("HomeTableViewController", image: "tabbar_home",title: "首页")
        addChildViewController("MessageTableViewController",image: "tabbar_message_center",title: "消息")
        addChildViewController("DiscoverTableViewController",image: "tabbar_discover",title: "广场")
        addChildViewController("MessageTableViewController",image: "tabbar_profile",title: "我")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addChildViewController(childController: String,image:String,title:String) {

        let name = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        let cls:AnyClass? = NSClassFromString(name + "."+childController)
        print(cls)
        let vcCls = cls as! UIViewController.Type
        
        let vc = vcCls.init()
        vc.title = title
        
        let nav = UINavigationController.init(rootViewController: vc)
        vc.tabBarItem.image = UIImage.init(named: image)
        vc.tabBarItem.selectedImage = UIImage.init(named: image+"_highlighted")
        addChildViewController(nav)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
