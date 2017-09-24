//
//  AppDelegate.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
//    var oauth: LFOAuth?
//    
//    var user: LFUser?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //设置全局Tabbar颜色
        UITabBar.appearance().tintColor = UIColor.orange
        
        //设置全局navigationBar颜色
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        return true
    }
}

//json解析
func json() {
    guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings", ofType: "json") else {
        return
    }
    
    guard let jsonData = NSData(contentsOfFile: jsonPath) else {
        return
    }
    
    guard let jsonArr = try? JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: AnyObject]] else {
        return
    }
    
    for obj in jsonArr {
        print(obj)
    }
}

