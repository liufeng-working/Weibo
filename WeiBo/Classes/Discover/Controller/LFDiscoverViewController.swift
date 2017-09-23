//
//  LFDiscoverViewController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFDiscoverViewController: LFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
    }
}
