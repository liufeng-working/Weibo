//
//  LFComposeViewModel.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/10/10.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFComposeViewModel: NSObject {

}

//MARK: - 发送微博
extension LFComposeViewModel {
    
    static func sendStatus(statusText: String, success: ((_ isSuccess: Bool) -> ())?, failure: ((_ error: Error) -> ())?) {
        
        guard let access_token = LFOAuthViewModel.shareOAuth.oauth?.access_token else {
            return
        }
        let urlStr = weibo_send
        let param = ["access_token": access_token,
                     "status": statusText]
        LFHTTPManager.shareManager.POST(urlStr: urlStr, parameters: param, success: { (result: [String: Any]) in
            
        }) { (error: Error) in
            failure?(error)
        }
    }
}
