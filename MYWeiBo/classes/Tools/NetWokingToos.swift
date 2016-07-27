//
//  NetWokingToos.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/21.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit
import AFNetworking


class NetWokingToos: NSObject {
  
    private lazy var netManger:AFHTTPSessionManager = {
        let baseUrl = NSURL.init(string: "https://api.weibo.com/")
        let manger = AFHTTPSessionManager.init(baseURL: baseUrl)
        manger.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json", "text/json", "text/javascript","text/plain") as? Set<String>
        return manger
    }()
    
   static let instance : NetWokingToos = {
    
        let manage = NetWokingToos()
      //  manage.baseURL = NSURL.init(string: "")
        return manage
        
    }()
    
    class func sharedManger() ->NetWokingToos{
       return instance
    }

    func startGET(api:String,pamre:AnyObject?,success: ((AnyObject?) -> Void)?,failure: ((NSURLSessionDataTask?, NSError) -> Void)?){
    
       netManger.GET(api, parameters: pamre, progress: nil, success: { (_, JSON) in
        
         if let date = JSON
         {
            success!(JSON)
         //  print(date)
         }
        
        }) { (_, error) in
            print(error)
        }
   }
    
    func startPOST(api:String,pamre:AnyObject?,success: ((AnyObject?) -> Void)?,failure: ((NSURLSessionDataTask?, NSError) -> Void)?){
        
        netManger.POST(api, parameters: pamre, progress: nil, success: { (_, JSON) in
            
            if let date = JSON
            {
                success!(JSON)
                print(date)
            }
            
        }) { (_, error) in
            print(error)
        }
    }
    
}
