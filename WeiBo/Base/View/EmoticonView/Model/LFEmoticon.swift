//
//  LFEmoticon.swift
//  Emotcion
//
//  Created by 刘丰 on 2017/10/9.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFEmoticon: NSObject {
    
    /// emoji
    var code: String?
    var emoji: String {
        guard let code = self.code else {
            return ""
        }
        
        let scanner = Scanner(string: code)
        var hex: UInt32 = 0
        scanner.scanHexInt32(&hex)
        return String(Character(Unicode.Scalar(hex)!))
    }
    
    /// 普通表情
    var png: String?
    var pngPath: String {
        guard let png = self.png else {
            return ""
        }
        return Bundle.main.bundlePath + "/Emoticons.bundle" + "/\(self.id)" + "/\(png)"
    }
    
    var chs: String?
    
    var id: String = ""
    
    var isRemove = false
    
    var isEmpty = false
    
    init(dict: [String: String]) {
        super.init()
        
        self.code = dict["code"]
        self.png = dict["png"]
        self.chs = dict["chs"]
    }
    
    init(isRemove: Bool, isEmpty: Bool) {
        super.init()
        
        self.isRemove = isRemove
        self.isEmpty = isEmpty
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
