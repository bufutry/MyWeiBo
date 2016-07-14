//
//  NavigationItem+Button.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/14.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
   
    class func customItem(target: AnyObject?,action: Selector,imageName:String)->UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), forState: .Normal)
        btn.setImage(UIImage.init(named: imageName+"_highlighted"), forState: .Highlighted)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        btn.sizeToFit()
        let itme = UIBarButtonItem.init(customView: btn)
        
        return itme
    }
 
}