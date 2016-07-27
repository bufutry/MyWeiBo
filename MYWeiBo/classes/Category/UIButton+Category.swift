//
//  UIButton+Category.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/26.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

extension UIButton{
    class func creatWith(title:String,image:String) -> UIButton{
        let btn = UIButton()
        btn.setTitle(title, forState: .Normal)
        btn.setTitle(title, forState: .Highlighted)
        btn.setImage(UIImage.init(named: image), forState: .Normal)
        btn.setBackgroundImage(UIImage.init(named: "timeline_card_bottom_background"), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        return btn
    }

}