//
//  LFUserViewModel.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFUserViewModel: NSObject {
    public static let shareUser = LFUserViewModel()
    
    var user: LFUser?
    
    var userPath: String {
        return lfDocumentPath.appending("/\(lf_weibo_userPath)")
    }
    
    override init() {
        super.init()
        self.user = NSKeyedUnarchiver.unarchiveObject(withFile: userPath) as? LFUser
    }
}
