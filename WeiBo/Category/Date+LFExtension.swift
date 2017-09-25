//
//  Date+LFExtension.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import Foundation

extension Date {
    static func dateString(originString: String, originStringDateFormat: String = "EEE MM dd HH:mm:ss Z yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = originStringDateFormat
        dateFormatter.locale = Locale(identifier: "en")
        
        var timeStr = ""
        if let createAtDate = dateFormatter.date(from: originString) {
            let interval = -createAtDate.timeIntervalSinceNow
            if interval < 0 {
                timeStr = "穿越了"
            }else if interval < 10 {//10秒内
                timeStr = "刚刚"
            }else if interval < 60 {
                timeStr = "1分钟内"
            }else if interval < 60*60 {
                timeStr = "\(Int(interval)/60)分钟前"
            }else if interval < 60*60*24 {
                timeStr = "\(Int(interval)/60/60)小时前"
            }else if interval < 60*60*24*2 {
                dateFormatter.dateFormat = "昨天 HH:mm"
                timeStr = dateFormatter.string(from: createAtDate)
            }else if interval < 60*60*24*3 {
                dateFormatter.dateFormat = "前天 HH:mm"
                timeStr = dateFormatter.string(from: createAtDate)
            }else {
                let calendar = Calendar.current
                let component = calendar.dateComponents(Set<Calendar.Component>([.year]), from: createAtDate, to: Date())
                if component.year! < 1 {
                    dateFormatter.dateFormat = "MM-dd HH:mm"
                    timeStr = dateFormatter.string(from: createAtDate)
                }else {
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    timeStr = dateFormatter.string(from: createAtDate)
                }
            }
        }
        return timeStr
    }
}
