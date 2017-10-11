//
//  LFMessageViewController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFMessageViewController: LFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
        
        self.navigationController?.navigationBar.addSubview(self.label)
    }
    
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        label.text = "测试动态字体"
        return label
    }()
}
