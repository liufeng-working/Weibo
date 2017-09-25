//
//  LFStatus.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFStatus: NSObject {

    /// 
    var statuses: [LFStatusModel]?

    ///
    var advertises: [Any]?

    ///
    var ad: [Any]?
    
    ///
    var hasvisible: Bool?

    ///
    var previous_cursor: Int?
    
    ///
    var next_cursor: Int?
    
    /// 总条数
    var total_number: Int?
    
    ///
    var interval: Int?
    
    ///
    var uve_blank: Int?
    
    ///
    var since_id: Int?
    
    ///
    var max_id: Int?
    
    ///
    var has_unread: Int?

    init(dict: [String: Any]) {
        super.init()
        
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
