//
//  LFTitleButton.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFTitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(UIImage(named: "navigationbar_arrow_down"), for: UIControlState.normal)
        self.setImage(UIImage(named: "navigationbar_arrow_up"), for: UIControlState.selected)
        self.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel?.frame.origin.x = 0
        self.imageView?.frame.origin.x = self.titleLabel!.frame.origin.x + self.titleLabel!.frame.size.width + 5
    }
}
