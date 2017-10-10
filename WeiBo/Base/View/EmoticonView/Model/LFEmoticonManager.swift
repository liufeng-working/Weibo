//
//  LFEmoticonManager.swift
//  Emotcion
//
//  Created by 刘丰 on 2017/10/9.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFEmoticonManager: NSObject {
    static let shareManager = LFEmoticonManager()
    var packages = [LFEmoticonPackage]()
    
    override init() {
        super.init()

        //最近
        self.packages.append(LFEmoticonPackage())
        
        //默认
        self.packages.append(LFEmoticonPackage(id: "com.sina.default"))
        
        //emoji
        self.packages.append(LFEmoticonPackage(id: "com.apple.emoji"))
        
        //浪小花
        self.packages.append(LFEmoticonPackage(id: "com.sina.lxh"))
    }
}
