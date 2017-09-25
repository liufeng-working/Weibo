//
//  LFPicture.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/26.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFPicture: NSObject {
    
    /// 小图
    var thumbnail_pic: String? {
        didSet {
            if let thumbnail_pic = self.thumbnail_pic {
                self.thumbnail_pic_url = URL(string: thumbnail_pic)
                self.bmiddle_pic_url = URL(string: (thumbnail_pic.replacingOccurrences(of: "thumbnail", with: "bmiddle")))
                self.original_pic_url = URL(string: (thumbnail_pic.replacingOccurrences(of: "thumbnail", with: "large")))
            }
        }
    }
    var thumbnail_pic_url: URL?
    
    /// 中图
    var bmiddle_pic_url: URL?
    
    /// 大图
    var original_pic_url: URL?
    
    init(dict: [String: String]) {
        super.init()
        
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    
    }
}
