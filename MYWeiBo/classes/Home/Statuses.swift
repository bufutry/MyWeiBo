//
//  Statuses.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/25.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class Statuses: NSObject{

        /// 时间
    var created_at:NSDate?
        /// 涞源
    var source:String?
        /// id
    var id:NSNumber?
        /// 正文
    var text:String?
    
    var user:User?
    
    
    let prorps = ["created_at","source","id","text"]
    override var description: String {
    
     let dic = dictionaryWithValuesForKeys(prorps)
     return "\(dic)"
    }
    
    
    init(dice:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dice)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print(key)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if "user" == key {
            user = User.init(dict: value as! [String:AnyObject])
        }
    }
    
    class  func loadSatuses(data:(netdata:[Statuses]?,error:NSError?)->())  {
        let aipName = "/2/statuses/home_timeline.json"
        let parms = ["access_token":currentAcount!.access_token!]
        
        NetWokingToos.sharedManger().startGET(aipName, pamre: parms, success: { (json) in
            print(json)
            let lists = json!["statuses"] as! [[String:AnyObject]]
            let satuseArray = transfromMode(lists)
            data(netdata:satuseArray,error: nil)
            }) { (_, error) in
                data(netdata: nil,error: error)
        }
    }
    

    
    private class func transfromMode(list:[[String:AnyObject]]) ->[Statuses]{
        var modes = [Statuses]()
        for dic in list {
         modes.append(Statuses.init(dice: dic))
        }
        return modes
    }
}


class User: NSObject {
     /// 头像
    var profile_image_url:String?
     /// 姓名
    var name:String?
     /// vip
    var mbrank:Int = 0
     /// V
    var verified:Int = 0
    
    
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

