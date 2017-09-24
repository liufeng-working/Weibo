//
//  LFOAuthViewModel.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFOAuthViewModel: NSObject {
    static func loadAccessToken(code: String, success: ((_ oauth: LFOAuth) -> ())?, failure: ((_ error: Error) -> ())?) {
        
        let urlStr = weibo_accessToken
        let param = ["client_id": weibo_oauth_appKey,
                     "client_secret": weibo_oauth_appSecret,
                     "grant_type": "authorization_code",
                     "code": code,
                     "redirect_uri": weibo_oauth_redirectUrl]
        
        LFHTTPManager.shareManager.POST(urlStr: urlStr, parameters: param, success: { (result: [String: Any]) in
            let oauth = LFOAuth(dict: result)
            success?(oauth);
        }) { (error: Error) in
            failure?(error)
        }
    }
    
    static func loaduserInfo(accessToken: String, uid: String, success: ((_ user: LFUser) -> ())?, failure: ((_ error: Error) -> ())?) {
        
        let urlStr = weibo_userShow
        let param = ["access_token": accessToken,
                     "uid": uid]
        LFHTTPManager.shareManager.GET(urlStr: urlStr, parameters: param, success: { (result: [String: Any]) in
            let user = LFUser(dict: result)
            success?(user)
        }) { (error: Error) in
            failure?(error)
        }
    }
}
