//
//  LFHomeViewModel.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFHomeViewModel: NSObject {
    
}

//MARK: - 请求
extension LFHomeViewModel {
    
    static func loadHomeTimeline(success: ((_ statusMs: [LFStatusModel]) -> ())?, failure: ((_ error: Error) -> ())?) {
        
        let urlStr = weibo_home_timeline
        let param = ["access_token": (LFOAuthViewModel.shareOAuth.oauth?.access_token)!]
        LFHTTPManager.shareManager.GET(urlStr: urlStr, parameters: param, success: { (result: [String: Any]) in
            var temArr = [LFStatusModel]()
            for statusDic in result["statuses"] as! [[String: Any]] {
                let statusM = LFStatusModel(dict: statusDic)
                temArr.append(statusM)
            }
            success?(temArr)
        }) { (error: Error) in
            failure?(error)
        }
    }
}
