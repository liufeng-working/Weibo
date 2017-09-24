//
//  LFOAuth.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFOAuth: NSObject, NSCoding {
    //授权后的accessToken
    var access_token: String?
    
    //令牌过期时间
    var expires_in: TimeInterval = 0.0 {
        didSet {
            self.expires_date = Date(timeIntervalSinceNow: self.expires_in)
        }
    }
    var expires_date: Date?
    
    //用户id
    var uid: String?
    
    //是否实名
    var isRealName: Bool?
    
    init(dict: [String: Any]) {
        super.init()
        
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    //归档、解档
    func encode(with aCoder: NSCoder) {
        self.encoder(with: aCoder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.decoder(coder: aDecoder)
    }
}

//MARK: - 归档、解档
extension LFOAuth {
    func encoder(with aCoder: NSCoder) {
        aCoder.encode(self.access_token, forKey: "access_token")
        aCoder.encode(self.expires_date, forKey: "expires_date")
        aCoder.encode(self.uid, forKey: "uid")
        aCoder.encode(self.isRealName, forKey: "isRealName")
    }
    
    func decoder(coder aDecoder: NSCoder) {
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        self.expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        self.uid = aDecoder.decodeObject(forKey: "uid") as? String
        self.isRealName = aDecoder.decodeObject(forKey: "isRealName") as? Bool
    }
}
