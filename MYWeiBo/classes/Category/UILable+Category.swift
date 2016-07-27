//
//  UILable+Category.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/26.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

extension UILabel{
    
    class func creatLableWith(color:UIColor,fontSize:CGFloat) ->UILabel{
        let  lab = UILabel()
        lab.textColor = color
        lab.font = UIFont.systemFontOfSize(fontSize)
     return lab
    }
 
}
