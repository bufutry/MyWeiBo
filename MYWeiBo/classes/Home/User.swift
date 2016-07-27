//
//  User.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/27.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class User: NSObject {
    /// 头像
    var profile_image_url:String?
        {
        didSet{
            if let str = profile_image_url {
                av_url = NSURL.init(string: str)
            }
        }
    }
    var av_url:NSURL?
    
    /// 姓名
    var name:String?
    /// vip
    var mbrank:Int = 0
        {
        didSet{
            
            if mbrank>0&&mbrank<7 {
                vipImage = UIImage.init(named: "common_icon_membership_level"+"\(mbrank)")
            }
        }
        
    }
    
    var vipImage:UIImage?
    
    /// V
    var verified_type:Int = 0
        {
        didSet{
            switch verified_type
            {
            case 0:
                verifiedImage = UIImage(named: "avatar_vip")
            case 2, 3, 5:
                verifiedImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                verifiedImage = UIImage(named: "avatar_grassroot")
            default:
                verifiedImage = nil
            }
        }
        
        
    }
    var verifiedImage:UIImage?
    
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    let proptrys = ["profile_image_url","name","mbrank","verified"]
    
    override var description: String{
        let dict = dictionaryWithValuesForKeys(proptrys)
        
        return "\(dict)"
        
    }
    
}

