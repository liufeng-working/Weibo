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

//MARK: - 请求用户微博
extension LFHomeViewModel {
    
    static func loadHomeTimeline(since_id: Int, max_id: Int, success: ((_ statusMs: [LFStatusModel]) -> ())?, failure: ((_ error: Error) -> ())?) {
        
        guard let access_token = LFOAuthViewModel.shareOAuth.oauth?.access_token else {
            return
        }
        let urlStr = weibo_home_timeline
        let param = ["access_token": access_token,
                     "since_id": "\(since_id)",
                     "max_id": "\(max_id)"]
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
