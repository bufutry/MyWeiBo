//
//  Statuses.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/25.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit
import SDWebImage

class Statuses: NSObject{

        /// 时间
    var created_at:String?{
        
        didSet{
            let formater = NSDateFormatter()
            formater.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
             formater.locale = NSLocale(localeIdentifier: "en")
            let date = formater.dateFromString(created_at!)
           dateDesc = date!.descDate()
        }
    
    }
    var dateDesc:String?
    
        /// 来源
    var source:String?{
        didSet{
            if source==nil || source=="" {
                source = ""
            }
           else
            {
            let tmp = source! as NSString
            let r = tmp.rangeOfString(">").location
            let e = tmp.rangeOfString("</").location
            source = "来自:" + tmp.substringWithRange(NSMakeRange(r+1, e-r-1))
            }
            
        }
    }
        /// id
    var id:NSNumber?
        /// 正文
    var text:String?
        /// 用户信息
    var user:User?
        /// 配图
    var pic_urls:[[String:String]]?{
        didSet{
        
            storePic = [NSURL]()
            if pic_urls != nil {
                for dice in pic_urls!  {
                    storePic?.append(NSURL.init(string: dice["thumbnail_pic"]!)!)
                }
            }
        }
    
    }
    var storePic:[NSURL]?
    
    
    
    var cellHeight:CGFloat = 0.0
    
    
    
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
       // print(key)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if "user" == key {
            user = User.init(dict: value as! [String:AnyObject])
        }
        else{
          super.setValue(value, forKey: key)
        }
    }
    
    class  func loadSatuses(data:(netdata:[Statuses]?,error:NSError?)->())  {
        let aipName = "/2/statuses/home_timeline.json"
        let parms = ["access_token":currentAcount!.access_token!]
        
        NetWokingToos.sharedManger().startGET(aipName, pamre: parms, success: { (json) in
            let lists = json!["statuses"] as! [[String:AnyObject]]
            let satuseArray = transfromMode(lists)
            downImage(satuseArray, data: data)
           // data(netdata:satuseArray,error: nil)
            }) { (_, error) in
                data(netdata: nil,error: error)
        }
    }
    
    private class func downImage(list:[Statuses]?,data:(netdata:[Statuses]?,error:NSError?)->()){
       
         let  group = dispatch_group_create()
        for status in list! {
            guard (status.storePic != nil) else{
              continue
            }
            
            for url in status.storePic! {
                dispatch_group_enter(group)
                SDWebImageManager.sharedManager().downloadWithURL(url, options: .RetryFailed, progress: nil, completed: { (_, _, _, _) in
                    dispatch_group_leave(group)
                })
            }
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { 
            data(netdata: list,error: nil)
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



