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
        addaddChildViewControllers()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setComposeBtn()
    }
    
    private func addaddChildViewControllers(){
        
     let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
            if let paths = path {
            
                do{
                let diceData = NSData(contentsOfFile: paths)
                let jsonAarr = try NSJSONSerialization.JSONObjectWithData(diceData!, options: .MutableContainers)
                
                    for dict in jsonAarr as![[String:String]] {
                        addChildViewController(dict["vcName"]!, image: dict["imageName"]!, title: dict["title"]!)
                    }
                }
                catch
                {
                    addChildViewController("HomeTableViewController", image: "tabbar_home",title: "首页")
                    addChildViewController("MessageTableViewController",image: "tabbar_message_center",title: "消息")
                    addChildViewController("NullTableViewController",image: "",title: "")
                    addChildViewController("DiscoverTableViewController",image: "tabbar_discover",title: "广场")
                    addChildViewController("MeTableViewController",image: "tabbar_profile",title: "我")
                }
            }
        

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

    //MARK:btn
    private lazy var composBtn:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add"), forState: .Normal)
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
         btn.addTarget(self, action:#selector(WBTabBarViewController.composeBtnClick), forControlEvents: .TouchUpInside)
        return btn
    }()
    
    private func setComposeBtn(){
        let width = UIScreen.mainScreen().bounds.width/CGFloat(childViewControllers.count)
        composBtn.frame = CGRectMake(width*2, 0, width, 49)
        tabBar.addSubview(composBtn)
    }

    
    func composeBtnClick() {
       print(#function)
        selectedIndex = 2
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
