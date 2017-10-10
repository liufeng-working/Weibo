//
//  LFEmoticonPackage.swift
//  Emotcion
//
//  Created by 刘丰 on 2017/10/9.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFEmoticonPackage: NSObject {
    var emoticons = [LFEmoticon]()
    
    override init() {
        super.init()
        
        self.addEmpty()
    }
    
    init(id: String) {
        super.init()
        
        let infoPath = Bundle.main.path(forResource: "\(id)/info", ofType: "plist", inDirectory: "Emoticons.bundle")!
        let emoticonDics = NSArray(contentsOfFile: infoPath) as! [[String: String]]
        
        var index = 0
        for dict in emoticonDics {
            let emoticon = LFEmoticon(dict: dict)
            emoticon.id = id
            self.emoticons.append(emoticon)
            
            //添加删除表情
            index += 1
            if index == 20 {
                self.emoticons.append(LFEmoticon(isRemove: true, isEmpty: false))
                index = 0
            }
        }
        
        self.addEmpty()
    }
    
    /// 添加空白
    func addEmpty() {
        let count = self.emoticons.count%21
        for _ in count..<20  {
            self.emoticons.append(LFEmoticon(isRemove: false, isEmpty: true))
        }
        self.emoticons.append(LFEmoticon(isRemove: true, isEmpty: false))
    }
}
