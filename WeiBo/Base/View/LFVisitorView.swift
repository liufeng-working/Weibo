//
//  LFVisitorView.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFVisitorView: UIView {
    
    //MARK: - 控件的属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipView: UILabel!

    weak var delegate: LFVisitorViewDelegate?

    //MARK: - 类方法获取实例对象
    static func visitorView() -> LFVisitorView {
        return Bundle.main.loadNibNamed("LFVisitorView", owner: nil, options: nil)?.first as! LFVisitorView
    }
    
    //MARK: - 设置控件内容的函数
    func setupVisitorViewInfo(iconName: String, title: String) {
        self.iconView.image = UIImage(named: iconName)
        self.tipView.text = title
        self.rotationView.isHidden = true
    }
    
    //MARK: - 旋转动画
    func rotationViewAnimation() {
        guard self.rotationView.isHidden else {
            return
        }
        
        let rotationA = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationA.fromValue = 0
        rotationA.toValue = Float.pi*2
        rotationA.duration = 10
        rotationA.repeatCount = MAXFLOAT
        rotationA.isRemovedOnCompletion = false
        self.rotationView.layer.add(rotationA, forKey: nil)
    }
    
    //MARK: - 登录注册点击事件
    @IBAction func registorButtonClick(_ sender: UIButton) {
        self.delegate?.registorClick(visitorView: self)
    }
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
        self.delegate?.loginClick(visitorView: self)
    }
}

protocol LFVisitorViewDelegate: NSObjectProtocol {
    
    func registorClick(visitorView: LFVisitorView)
    
    func loginClick(visitorView: LFVisitorView)
}
