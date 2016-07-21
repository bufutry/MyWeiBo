//
//  NetWokingToos.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/21.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit
import AFNetworking


class NetWokingToos: AFHTTPSessionManager {
  
   static let instance : NetWokingToos = {
      
        let manage = NetWokingToos()
      //  manage.baseURL = NSURL.init(string: "")
        return manage
        
    }()
    
    class func sharedManger() ->NetWokingToos{
       return instance
    }
    
}
