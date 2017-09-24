//
//  LFUser.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFUser: NSObject, NSCoding {
    
    // 用户UID
    var id: Int?
    
    //字符串型的用户UID
    var idstr: String?
    
    //用户昵称
    var screen_name: String?
    
    //友好显示名称
    var name: String?
    
    //用户所在省级ID
    var province: Int?
    
    //用户所在城市ID
    var city: Int?
    
    //用户所在地
    var location: String?
    
    //用户个人描述
//    var description: String?
    
    //用户博客地址
    var url: String?
    
    //用户头像地址（中图），50×50像素
    var profile_image_url: String?
    
    //用户的微博统一URL地址
    var profile_url: String?
    
    //用户的个性化域名
    var domain: String?
    
    //用户的微号
    var weihao: String?
    
    //性别，m：男、f：女、n：未知
    var gender: String?
    
    //粉丝数
    var followers_count: Int?
    
    //关注数
    var friends_count: Int?
    
    //微博数
    var statuses_count: Int?
    
    //收藏数
    var favourites_count: Int?
    
    //用户创建（注册）时间
    var created_at: String?
    
    //暂未支持
    var following: Bool?
    
    //是否允许所有人给我发私信，true：是，false：否
    var allow_all_act_msg: Bool?
    
    //是否允许标识用户的地理位置，true：是，false：否
    var geo_enabled: Bool?
    
    //是否是微博认证用户，即加V用户，true：是，false：否
    var verified: Bool?
    
    //暂未支持
    var verified_type: Int?
    
    //用户备注信息，只有在查询用户关系时才返回此字段
    var remark: String?
    
    //用户的最近一条微博信息字段 详细
    var status: Any?
    
    //是否允许所有人对我的微博进行评论，true：是，false：否
    var allow_all_comment: Bool?
    
    //用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    //用户头像地址（高清），高清头像原图
    var avatar_hd: String?
    
    //认证原因
    var verified_reason: String?
    
    //该用户是否关注当前登录用户，true：是，false：否
    var follow_me: Bool?
    
    //用户的在线状态，0：不在线、1：在线
    var online_status: Int?
    
    //用户的互粉数
    var bi_followers_count: Int?
    
    //用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
    var lang: String?
    
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
extension LFUser {
    func encoder(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.idstr, forKey: "idstr")
        aCoder.encode(self.screen_name, forKey: "screen_name")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.province, forKey: "province")
        aCoder.encode(self.city, forKey: "city")
        aCoder.encode(self.location, forKey: "location")
//        aCoder.encode(self.description, forKey: "description")
        aCoder.encode(self.url, forKey: "url")
        aCoder.encode(self.profile_image_url, forKey: "profile_image_url")
        aCoder.encode(self.profile_url, forKey: "profile_url")
        aCoder.encode(self.domain, forKey: "domain")
        aCoder.encode(self.weihao, forKey: "weihao")
        aCoder.encode(self.gender, forKey: "gender")
        aCoder.encode(self.followers_count, forKey: "followers_count")
        aCoder.encode(self.friends_count, forKey: "friends_count")
        aCoder.encode(self.statuses_count, forKey: "statuses_count")
        aCoder.encode(self.favourites_count, forKey: "favourites_count")
        aCoder.encode(self.created_at, forKey: "created_at")
        aCoder.encode(self.following, forKey: "following")
        aCoder.encode(self.allow_all_act_msg, forKey: "allow_all_act_msg")
        aCoder.encode(self.geo_enabled, forKey: "geo_enabled")
        aCoder.encode(self.verified, forKey: "verified")
        aCoder.encode(self.verified_type, forKey: "verified_type")
        aCoder.encode(self.remark, forKey: "remark")
        aCoder.encode(self.status, forKey: "status")
        aCoder.encode(self.allow_all_comment, forKey: "allow_all_comment")
        aCoder.encode(self.avatar_large, forKey: "avatar_large")
        aCoder.encode(self.avatar_hd, forKey: "avatar_hd")
        aCoder.encode(self.verified_reason, forKey: "verified_reason")
        aCoder.encode(self.follow_me, forKey: "follow_me")
        aCoder.encode(self.online_status, forKey: "online_status")
        aCoder.encode(self.bi_followers_count, forKey: "bi_followers_count")
        aCoder.encode(self.lang, forKey: "lang")
    }
    
    func decoder(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.idstr = aDecoder.decodeObject(forKey: "idstr") as? String
        self.screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.province = aDecoder.decodeObject(forKey: "province") as? Int
        self.city = aDecoder.decodeObject(forKey: "city") as? Int
        self.location = aDecoder.decodeObject(forKey: "location") as? String
//        self.description = aDecoder.decodeObject(forKey: "description") as? String
        self.url = aDecoder.decodeObject(forKey: "url") as? String
        self.profile_image_url = aDecoder.decodeObject(forKey: "profile_image_url") as? String
        self.profile_url = aDecoder.decodeObject(forKey: "profile_url") as? String
        self.domain = aDecoder.decodeObject(forKey: "domain") as? String
        self.weihao = aDecoder.decodeObject(forKey: "weihao") as? String
        self.gender = aDecoder.decodeObject(forKey: "gender") as? String
        self.followers_count = aDecoder.decodeObject(forKey: "followers_count") as? Int
        self.friends_count = aDecoder.decodeObject(forKey: "friends_count") as? Int
        self.statuses_count = aDecoder.decodeObject(forKey: "statuses_count") as? Int
        self.favourites_count = aDecoder.decodeObject(forKey: "favourites_count") as? Int
        self.created_at = aDecoder.decodeObject(forKey: "created_at") as? String
        self.following = aDecoder.decodeObject(forKey: "following") as? Bool
        self.allow_all_act_msg = aDecoder.decodeObject(forKey: "allow_all_act_msg") as? Bool
        self.geo_enabled = aDecoder.decodeObject(forKey: "geo_enabled") as? Bool
        self.verified = aDecoder.decodeObject(forKey: "verified") as? Bool
        self.verified_type = aDecoder.decodeObject(forKey: "verified_type") as? Int
        self.remark = aDecoder.decodeObject(forKey: "remark") as? String
        self.status = aDecoder.decodeObject(forKey: "status")
        self.allow_all_comment = aDecoder.decodeObject(forKey: "allow_all_comment") as? Bool
        self.avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        self.avatar_hd = aDecoder.decodeObject(forKey: "avatar_hd") as? String
        self.verified_reason = aDecoder.decodeObject(forKey: "verified_reason") as? String
        self.follow_me = aDecoder.decodeObject(forKey: "follow_me") as? Bool
        self.online_status = aDecoder.decodeObject(forKey: "online_status") as? Int
        self.bi_followers_count = aDecoder.decodeObject(forKey: "bi_followers_count") as? Int
        self.lang = aDecoder.decodeObject(forKey: "lang") as? String
    }
}


