//
//  LFEmoticonCell.swift
//  Emotcion
//
//  Created by 刘丰 on 2017/10/9.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFEmoticonCell: UICollectionViewCell {
    
    var emoticon: LFEmoticon? {
        didSet {
            guard let emoticon = self.emoticon else {
                return
            }
            self.button.setTitle(emoticon.emoji, for: UIControlState.normal)
            self.button.setImage(UIImage(contentsOfFile: emoticon.pngPath), for: UIControlState.normal)
            
            if emoticon.isRemove {
                self.button.setImage(UIImage(named: "compose_emotion_delete"), for: UIControlState.normal)
            }
        }
    }
    
    
    fileprivate lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(button)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: - UI
extension LFEmoticonCell {
    fileprivate func setupUI() {
        let views: [String: Any] = ["button": self.button]
        
        let hCon = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[button]-0-|", options: [], metrics: nil, views: views)
        self.contentView.addConstraints(hCon)
        
        let vCon = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[button]-0-|", options: [], metrics: nil, views: views)
        self.contentView.addConstraints(vCon)
    }
}
