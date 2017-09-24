//
//  LFLog.swift
//  LFStudy-swift
//
//  Created by 刘丰 on 2017/9/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

func LFLog(_ message: Any..., separator: String = " ", terminator: String  = "\n", file: String = #file, funcName: String = #function, line: Int = #line) {
    #if DEBUG
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        let dateStr = dateFormatter.string(from: Date())
        let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as! String
        print("\(dateStr):\(bundleName)")
        let fileName = (file as NSString).lastPathComponent
        print("<\(fileName):\(line)>")
        if message.count != 0 {
            for (i, item) in message.enumerated() {
                print(item, separator: "", terminator: "")
                if i == message.count - 1 {
                    print(terminator, separator: "", terminator: "")
                }else {
                    print(separator, separator: "", terminator: "")
                }
            }
        }
        if terminator != "\n" {
            print("")
        }
        print("-----------------------------------------")
    #endif
}
