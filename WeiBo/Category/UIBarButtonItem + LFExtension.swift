//
//  UIBarButtonItem + LFExtension.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageNamed: String, target: Any? = nil, action: Selector? = nil) {
        self.init()
        
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: imageNamed), for: UIControlState.normal)
        if let target = target, let action = action {
            leftBtn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        }
        leftBtn.sizeToFit()
        self.customView = leftBtn
    }
    
    convenience init(imageNamed: String, highlightedImageNamed: String, target: Any? = nil, action: Selector? = nil) {
        self.init()
        
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: imageNamed), for: UIControlState.normal)
        leftBtn.setImage(UIImage(named: highlightedImageNamed), for: UIControlState.highlighted)
        if let target = target, let action = action {
            leftBtn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        }
        leftBtn.sizeToFit()
        self.customView = leftBtn
    }
    
    convenience init(backgroundImageNamed: String, target: Any? = nil, action: Selector? = nil) {
        self.init()
        
        let leftBtn = UIButton()
        leftBtn.setBackgroundImage(UIImage(named: backgroundImageNamed), for: UIControlState.normal)
        if let target = target, let action = action {
            leftBtn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        }
        leftBtn.sizeToFit()
        self.customView = leftBtn
    }
    
    convenience init(backgroundImageNamed: String, highlightedBackgroundImageNamed: String, target: Any? = nil, action: Selector? = nil) {
        self.init()
        
        let leftBtn = UIButton()
        leftBtn.setBackgroundImage(UIImage(named: backgroundImageNamed), for: UIControlState.normal)
        leftBtn.setBackgroundImage(UIImage(named: highlightedBackgroundImageNamed), for: UIControlState.highlighted)
        if let target = target, let action = action {
            leftBtn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        }
        leftBtn.sizeToFit()
        self.customView = leftBtn
    }
    
    convenience init(imageNamed: String, highlightedImageNamed: String, backgroundImageNamed: String, highlightedBackgroundImageNamed: String, target: Any? = nil, action: Selector? = nil) {
        self.init()
     
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: imageNamed), for: UIControlState.normal)
        leftBtn.setImage(UIImage(named: highlightedImageNamed), for: UIControlState.highlighted)
        leftBtn.setBackgroundImage(UIImage(named: backgroundImageNamed), for: UIControlState.normal)
        leftBtn.setBackgroundImage(UIImage(named: highlightedBackgroundImageNamed), for: UIControlState.highlighted)
        if let target = target, let action = action {
            leftBtn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        }
        leftBtn.sizeToFit()
        self.customView = leftBtn
    }
}
