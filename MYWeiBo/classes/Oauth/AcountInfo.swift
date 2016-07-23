//
//  AcountInfo.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/22.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

private let pathFile = "acount.plist".cacePath()
var currentAcount:AcountInfo?


class AcountInfo: NSObject ,NSCoding{
    
    var access_token:String?
    var expires_in:NSNumber?
    var screen_name:String?
    var profile_image_url:String?
    
    
    
    var uid:String?
    
    lazy var isExpTime:Bool = {
        
        let  date = NSDate(timeIntervalSinceReferenceDate:self.expires_in as!NSTimeInterval)
        let  result = NSDate().compare(date)
        return result != NSComparisonResult.OrderedAscending
    }()
    
    
    override var description: String{
        // 1.定义属性数组
        let properties = ["access_token", "expires_in", "uid","screen_name","profile_image_url"]
        // 2.根据属性数组, 将属性转换为字典
        let dict =  self.dictionaryWithValuesForKeys(properties)
        // 3.将字典转换为字符串
        return "\(dict)"
    }

    init(dice:Dictionary<String,AnyObject>) {
        super.init()
        setValuesForKeysWithDictionary(dice)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("not key")
    }
    
    //MARK: - save&&load
    
    
    
    func saveAcount() {
        NSKeyedArchiver.archiveRootObject(self, toFile: pathFile)
    }
    
    
   class func loadAcount() -> AcountInfo? {
        
        let acount = NSKeyedUnarchiver.unarchiveObjectWithFile(pathFile) as? AcountInfo
        currentAcount = acount
        return acount
    }
    
    class func isLogin() ->Bool {
    
        AcountInfo.loadAcount()

        if currentAcount == nil {
            return false
        }
        
        return  currentAcount!.isExpTime
    }
    
    //MARK: -NSCoding
    func encodeWithCoder(aCoder: NSCoder){
       aCoder.encodeObject(access_token, forKey: "access_token")
       aCoder.encodeObject(expires_in, forKey: "expires_in")
       aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(profile_image_url, forKey: "profile_image_url")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
    }
    
    required init?(coder aDecoder: NSCoder){
    access_token = aDecoder.decodeObjectForKey("access_token") as? String
    expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
    uid = aDecoder.decodeObjectForKey("uid") as? String
    screen_name = aDecoder.decodeObjectForKey("screen_name") as?String
     profile_image_url = aDecoder.decodeObjectForKey("profile_image_url") as?String
    }
}
