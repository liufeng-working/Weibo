//
//  LFStatusModel.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//  用户发布的每条微博模型

import UIKit
import SDWebImage

class LFStatusModel: NSObject {

    /// 微博创建时间
    var created_at: String? {
        didSet {
            if let created_at = self.created_at {
                self.created_at_str = Date.dateString(originString: created_at)
            }
        }
    }
    var created_at_str: String?
    
    /// 微博ID
    var id: Int?
    
    /// 微博MID
    var mid: Int?
    
    /// 字符串型的微博ID
    var idstr: String?
    
    /// 微博信息内容
    var text: String?
    
    /// 微博内容长度
    var textLength: Int?
    
    /// 微博来源
    var source: String? {
        didSet {
            guard let source = self.source,
            source != "" else {
                return
            }

            //"<a href="http://weibo.com" rel="nofollow">新浪微博</a>"
            let startIndex = (source as NSString).range(of: "\">").location + 2
            let length = (source as NSString).range(of: "</").location - startIndex
            self.source_str = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
    }
    var source_str: String?

    /// 配图
    var pic_urls: [LFPicture] = [] {
        didSet {
            
        }
    }
    
    /// 是否已收藏，true：是，false：否
    var favorited: Bool?
    
    /// 是否被截断，true：是，false：否
    var truncated: Bool?
    
    /// （暂未支持）回复ID
    var in_reply_to_status_id: String?
    
    /// （暂未支持）回复人UID
    var in_reply_to_user_id: String?
    
    /// （暂未支持）回复人昵称
    var in_reply_to_screen_name: String?
    
    /// 缩略图片地址，没有时不返回此字段
    var thumbnail_pic: String? {
        didSet {
            
        }
    }
    var thumbnail_pic_url: URL?
    
    /// 中等尺寸图片地址，没有时不返回此字段
    var bmiddle_pic: String?
    
    /// 原始图片地址，没有时不返回此字段
    var original_pic: String?
    
    /// 地理信息字段 详细
    var geo: Any?
    
    /// 微博作者的用户信息字段 详细
    var user: LFUser?
    
    /// 被转发的原微博信息字段，当该微博为转发微博时返回 详细
    var retweeted_status: LFStatusModel? {
        didSet {
            if let _ = self.retweeted_status {
                self.hasRetweet = true
            }
        }
    }
    var hasRetweet: Bool = false //有转发
    
    /// 转发数
    var reposts_count: Int = 0 {
        didSet {
            if self.reposts_count == 0 {
                self.reposts_str = "转发"
            }else if self.reposts_count < 1_0000 {
                self.reposts_str = "\(self.reposts_count)"
            }else {
                self.reposts_str = "\(self.reposts_count/1_0000)万"
            }
        }
    }
    var reposts_str: String?
    
    /// 评论数
    var comments_count: Int = 0 {
        didSet {
            if self.comments_count == 0 {
                self.comments_str = "评论"
            }else if self.comments_count < 1_0000 {
                self.comments_str = "\(self.comments_count)"
            }else {
                self.comments_str = "\(self.comments_count/1_0000)万"
            }
        }
    }
    var comments_str: String?
    
    /// 表态数
    var attitudes_count: Int = 0 {
        didSet {
            if self.attitudes_count == 0 {
                self.attitudes_str = "赞"
            }else if self.attitudes_count < 1_0000 {
                self.attitudes_str = "\(self.attitudes_count)"
            }else {
                self.attitudes_str = "\(self.attitudes_count/1_0000)万"
            }
        }
    }
    var attitudes_str: String?
    
    /// 暂未支持
    var mlevel: Int?
    
    /// 微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
    var visible: Any?
    
    /// 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url
    var pic_ids: Any?
    
    /// array	微博流内的推广微博ID
    var ad: Any?
    
    init(dict: [String: Any]) {
        super.init()
        
        self.setValuesForKeys(dict)
        
        /// 转成LFUser
        if let userDic = dict["user"] as? [String: Any] {
            self.user = LFUser(dict: userDic)
        }
        
        /// 取出配图
        self.setupPics(dict: dict)
        
        /// 转发的微博
        if let retweetDic = dict["retweeted_status"] as? [String: Any] {
            self.retweeted_status = LFStatusModel(dict: retweetDic)
            self.setupPics(dict: retweetDic)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    //处理配图
    private func setupPics(dict: [String: Any]) {
        if let picUrls = dict["pic_urls"] as? [[String: String]] {
            var tempA = [LFPicture]()
            for picUrlDic in picUrls {
                let picM = LFPicture(dict: picUrlDic)
                tempA.append(picM)
            }
            self.pic_urls = tempA
        }
    }
}
