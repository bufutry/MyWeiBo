//
//  UIView+Layout.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/13.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

public let ScreenWidth = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight = UIScreen.mainScreen().bounds.size.height

extension UIView{

    var MaxY:CGFloat{
        get{
            return CGRectGetMaxY(frame)
        }
        set{
            var r = frame
            r.origin.y = newValue - r.size.height
            frame = r
        }
    }
    
    var MaxX:CGFloat{
        
        get{
            
            return CGRectGetMaxX(frame)
        }
        
        set{
            var r = frame
            r.origin.x = newValue - r.size.width
            frame = r
        }
    }
    
    var x:CGFloat{
        get{
            return frame.origin.x
        }
        set{
            var r = frame
            r.origin.x = newValue
            frame = r
        }
    }
    
    var y:CGFloat{
        get{
            return frame.origin.y
        }
        set{
            var r = frame
            r.origin.y = newValue
            frame = r
        }
        
    }
    
    var width:CGFloat{
        get{
            return frame.size.width
        }
        set{
            var r = frame
            r.size.width = newValue
            frame = r
        }
    }
    
    var height:CGFloat{
        get{
            return frame.size.height
        }
        set{
            var r = frame
            r.size.height = newValue
            frame = r
        }
    }

}

