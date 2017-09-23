//
//  LFHTTPManager.swift
//  AF的封装
//
//  Created by 刘丰 on 2017/9/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit
import AFNetworking

class LFHTTPManager: AFHTTPSessionManager {
    public static let shareManager: LFHTTPManager = {
        let manager = LFHTTPManager()
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        return manager
    }()
}

//MARK: - 封装的方法
extension LFHTTPManager {
    
    //post
    public func POST(urlStr: String, parameters: [String: Any], success: ((_ object: Any) -> ())?, failure: ((_ error: Error) -> ())?) {
        self.post(urlStr, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            success?(responseObject!)
        }) { (task: URLSessionDataTask?, error: Error) in
            failure?(error)
        }
    }
    
    //get
    public func GET(urlStr: String, parameters: [String: Any], success: ((_ object: Any) -> ())?, failure: ((_ error: Error) -> ())?) {
        self.get(urlStr, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            success?(responseObject!)
        }) { (task: URLSessionDataTask?, error: Error) in
            failure?(error)
        }
    }
}
