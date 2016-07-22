//
//  NSString+FilePath.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/22.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

extension NSString{
    func docPath() -> String {
     
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        return (path! + "/" + (self as String))
    }
    
    func cacePath() -> String {
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        return (path! + "/" + (self as String))
    }
    
    func tmpPath() -> String {
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        return (path! + "/" + (self as String))
    }
}
