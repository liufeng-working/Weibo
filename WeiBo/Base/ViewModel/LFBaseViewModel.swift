//
//  LFBaseViewModel.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFBaseViewModel: NSObject {
    public static let baseViewModel = LFBaseViewModel()
    
    var oauth: LFOAuth?
    
    var oauthPath: String {
        return lfDocumentPath.appending("/\(lf_weibo_oauthPath)")
    }
    
    var isLogin: Bool {
        if let oauth = self.oauth,
            let expiresDate = oauth.expires_date,
            expiresDate.compare(Date()) == ComparisonResult.orderedDescending {
            return true
        }
        return false
    }
    
    override init() {
        super.init()
        self.oauth = NSKeyedUnarchiver.unarchiveObject(withFile: oauthPath) as? LFOAuth
    }
}
