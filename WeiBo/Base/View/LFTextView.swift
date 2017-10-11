//
//  LFTextView.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFTextView: UITextView {

    var placeholder: String? {
        didSet {
            if let placeholder = self.placeholder {
                self.phLabel.text = placeholder
            }
        }
    }
    
    override var font: UIFont? {
        didSet {
            self.phLabel.font = font
        }
    }
    
    override var attributedText: NSAttributedString! {
        didSet {
            self.textDidChange()
        }
    }
    
    fileprivate lazy var phLabel: UILabel = {
        let phL = UILabel()
        phL.textColor = UIColor.gray
        phL.font = self.font
        phL.text = "分享新鲜事..."
        self.addSubview(phL)
        return phL
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subView in self.subviews {
            if let className = NSClassFromString("_UITextContainerView"),
            subView.isKind(of: className) {
                self.phLabel.frame = CGRect(x: 10, y: 5, width: subView.frame.width, height: subView.frame.height)
                break
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - 重写方法
extension LFTextView {
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isFirstResponder {
            self.resignFirstResponder()
        }
    }
}

//MARK: - 监听事件
extension LFTextView {
    @objc fileprivate func textDidChange() {
        let hidden = self.hasText || self.attributedText.length != 0
        self.phLabel.isHidden = hidden
        NotificationCenter.default.post(name: NSNotification.Name.LFTextViewDidChangeNotification, object: hidden)
    }
}

extension NSNotification.Name {
    
    static let LFTextViewDidChangeNotification: NSNotification.Name = NSNotification.Name(rawValue: "LFTextViewDidChangeNotification")
}
