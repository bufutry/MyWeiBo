//
//  AcountInfo.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/22.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

private let pathFile = "acount.plist"
var currentAcount:AcountInfo?


class AcountInfo: NSObject ,NSCoding{
    
    var access_token:String?
    var expires_in:NSNumber?
    
    var uid:String?
    
    lazy var isExpTime:Bool = {
        
        let  date = NSDate(timeIntervalSinceReferenceDate:self.expires_in as!NSTimeInterval)
        let  result = NSDate().compare(date)
        return false
    }()
    
    
    

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
        return acount
    }
    
    class func isLogin() ->Bool {
    
        currentAcount = AcountInfo.loadAcount()

        if currentAcount == nil {
            return false
        }
        
        return  currentAcount!.isExpTime
    }
    
    //MARK: -NSCoding
    func encodeWithCoder(aCoder: NSCoder){
       aCoder.setValue(access_token, forKey: "access_token")
       aCoder.setValue(expires_in, forKey: "expires_in")
       aCoder.setValue(uid, forKey: "uid")
    }
    
    required init?(coder aDecoder: NSCoder){
    access_token = aDecoder.valueForKey("access_token") as? String
    expires_in = aDecoder.valueForKey("expires_in") as? NSNumber
    uid = aDecoder.valueForKey("uid") as? String
    }
}
