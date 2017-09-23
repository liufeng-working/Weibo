//
//  UIButton+LFExtension.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

extension UIButton {

    convenience init(imageNamed: String) {
        self.init()
        self.setImage(UIImage(named: imageNamed), for: UIControlState.normal)
        self.sizeToFit()
    }
    
    convenience init(imageNamed: String, highlightedImageNamed: String) {
        self.init()
        self.setImage(UIImage(named: imageNamed), for: UIControlState.normal)
        self.setImage(UIImage(named: highlightedImageNamed), for: UIControlState.highlighted)
        self.sizeToFit()
    }
    
    convenience init(imageNamed: String, selectedImageNamed: String) {
        self.init()
        self.setImage(UIImage(named: imageNamed), for: UIControlState.normal)
        self.setImage(UIImage(named: selectedImageNamed), for: UIControlState.selected)
        self.sizeToFit()
    }
    
    convenience init(backgroundImageNamed: String) {
        self.init()
        self.setBackgroundImage(UIImage(named: backgroundImageNamed), for: UIControlState.normal)
        self.sizeToFit()
    }
    
    convenience init(backgroundImageNamed: String, highlightedBackgroundImageNamed: String) {
        self.init()
        self.setBackgroundImage(UIImage(named: backgroundImageNamed), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named: highlightedBackgroundImageNamed), for: UIControlState.highlighted)
        self.sizeToFit()
    }
    
    convenience init(backgroundImageNamed: String, selectedBackgroundImageNamed: String) {
        self.init()
        self.setBackgroundImage(UIImage(named: backgroundImageNamed), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named: selectedBackgroundImageNamed), for: UIControlState.selected)
        self.sizeToFit()
    }
    
    convenience init(imageNamed: String, highlightedImageNamed: String, backgroundImageNamed: String, highlightedBackgroundImageNamed: String) {
        self.init()
        self.setImage(UIImage(named: imageNamed), for: UIControlState.normal)
        self.setImage(UIImage(named: highlightedImageNamed), for: UIControlState.highlighted)
        self.setBackgroundImage(UIImage(named: backgroundImageNamed), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named: highlightedBackgroundImageNamed), for: UIControlState.highlighted)
        self.sizeToFit()
    }
    
    convenience init(imageNamed: String, selectedImageNamed: String, backgroundImageNamed: String, selectedBackgroundImageNamed: String) {
        self.init()
        self.setImage(UIImage(named: imageNamed), for: UIControlState.normal)
        self.setImage(UIImage(named: selectedImageNamed), for: UIControlState.selected)
        self.setBackgroundImage(UIImage(named: backgroundImageNamed), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named: selectedBackgroundImageNamed), for: UIControlState.selected)
        self.sizeToFit()
    }
}
