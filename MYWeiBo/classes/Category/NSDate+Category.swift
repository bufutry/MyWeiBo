//
//  NSDate+Category.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/26.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

extension NSDate{

    func descDate() -> String?{
        
        let calender = NSCalendar.currentCalendar()
        let timer = Int(NSDate().timeIntervalSinceDate(self))
        // let nowTimer = NSDate.timeIntervalSinceDate(NSDate.init())
        
        
        //今天
        if calender.isDateInToday(self) {
            if timer<60 {
                return "刚刚"
            }
            
            if timer<60*60 {
                return "\(timer/60)分钟以前"
            }
            
            if timer<60*60*60 {
                return "\(timer/60/60)小时以前"
            }
        }
        
        // 2昨天
        var formatterStr = "HH:mm"
        if calender.isDateInYesterday(self)
        {
            // 昨天: HH:mm
            formatterStr =  "昨天:" +  formatterStr
        }else
        {
            // 3.处理一年以内
            formatterStr = "MM-dd " + formatterStr
            
            // 4.处理更早时间
            let comps = calender.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            if comps.year >= 1
            {
                formatterStr = "yyyy-" + formatterStr
            }
        }
        

        let formatter = NSDateFormatter()
        formatter.dateFormat = formatterStr
        formatter.locale = NSLocale(localeIdentifier: "en")

        
        return formatter.stringFromDate(self)

    }

}