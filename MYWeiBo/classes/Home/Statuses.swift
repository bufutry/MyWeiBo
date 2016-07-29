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
    var id:Int = 0
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
    
        /// 转发
    var retweeted_status:Statuses?
    var picList:[NSURL]?{
    
        get{
            return retweeted_status == nil ? storePic : retweeted_status?.storePic
        }
    }
    
    
    
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
            return
        }
        if "retweeted_status" == key {
            retweeted_status = Statuses.init(dice: value as! [String:AnyObject])
            return
        }
       
          super.setValue(value, forKey: key)
    }
    
    class  func loadSatuses(since_id:Int,max_id:Int,data:(netdata:[Statuses]?,error:NSError?)->())  {
        let aipName = "/2/statuses/home_timeline.json"
        var parms = ["access_token":currentAcount!.access_token!]
        if since_id>0 {
            parms["since_id"] = "\(since_id)"
        }
        
        if max_id>0 {
            parms["max_id"] = "\(max_id)"
        }
        
        NetWokingToos.sharedManger().startGET(aipName, pamre: parms, success: { (json) in
            let lists = json!["statuses"] as! [[String:AnyObject]]
            let satuseArray = transfromMode(lists)
                downImage(satuseArray, data: data)
            }) { (_, error) in
                data(netdata: nil,error: error)
        }
    }
    
    private class func downImage(list:[Statuses]?,data:(netdata:[Statuses]?,error:NSError?)->()){
       
        if list!.count == 0 || list == nil
        {
          //  data(netdata: list, error: nil)
            return
        }
        let  group = dispatch_group_create()
        for status in list! {
            guard (status.picList == nil) else{
              continue
            }
            for url in status.picList! {
                 dispatch_group_enter(group)
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) -> Void in
                    print("ok")
                    dispatch_group_leave(group)
                })
            }
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
           
            data(netdata: list,error: nil)
        }

//        dispatch_group_notify(group, dispatch_get_main_queue()) {
//           () -> Void in
//            data(netdata: list,error: nil)
//        }
    }

    
    private class func transfromMode(list:[[String:AnyObject]]) ->[Statuses]{
        var modes = [Statuses]()
        for dic in list {
         modes.append(Statuses.init(dice: dic))
        }
        return modes
    }
}



