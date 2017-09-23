//
//  LFTabBarController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFTabBarController: UITabBarController {
    
    lazy var composeBtn: UIButton = {
        let compose = UIButton(imageNamed: "tabbar_compose_icon_add", highlightedImageNamed: "tabbar_compose_button_highlighted", backgroundImageNamed: "tabbar_compose_button", highlightedBackgroundImageNamed: "tabbar_compose_button_highlighted")
        compose.sizeToFit()
        return compose
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComposeBtn()
    }
}

//MARK: - 设置UI
extension LFTabBarController {
    func setupComposeBtn() {
        self.tabBar.addSubview(self.composeBtn)
        self.composeBtn.center = CGPoint(x: self.tabBar.frame.size.width*0.5, y: self.tabBar.frame.size.height*0.5)
        self.composeBtn.addTarget(self, action: #selector(composeClick), for: UIControlEvents.touchUpInside)
    }
}

//MARK: - 监听事件
extension LFTabBarController {
    //发布按钮的点击事件
    func composeClick() {
        print(#function)
    }
}
