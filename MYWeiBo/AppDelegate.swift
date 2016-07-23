//
//  AppDelegate.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/11.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

public let NeedReturnMainVC = "NeedReturnMainVC"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        swipvc()
        window?.rootViewController = defultRootVc()
        window?.makeKeyAndVisible()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(AppDelegate.swipvc), name: NeedReturnMainVC, object: nil)
        return true
    }
    
    func swipvc() {
        window?.rootViewController = WBTabBarViewController()
    }
    
    func defultRootVc()->UIViewController?{
    
     if chechVision() {
        return NewFeatureViewController()
     }
    if AcountInfo.isLogin() {
        return WelcomViewController()
     }
      return WBTabBarViewController()
    }
  
    private func chechVision() -> Bool{
        let newV = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
        let keepV = NSUserDefaults.standardUserDefaults().objectForKey("cfVS")
        if newV?.floatValue>keepV?.floatValue {
            
            NSUserDefaults.standardUserDefaults().setObject(newV, forKey: "cfVS")
            return true
        }
        
        return false
        
    }
}

