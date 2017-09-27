//
//  LFPopoverPresentationController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFPopoverPresentationController: UIPresentationController {
    
    var presentedViewFrame = CGRect.zero
    
    fileprivate lazy var coverView: UIView = {
        let coverV = UIView()
        coverV.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return coverV
    }()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        self.presentedView?.frame = self.presentedViewFrame
        
        self.setupCoverView()
    }
}

//MARK: - UI
extension LFPopoverPresentationController {
    fileprivate func setupCoverView() {
        self.coverView.frame = self.containerView!.bounds
        self.containerView?.insertSubview(self.coverView, belowSubview: self.presentedView!)
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.coverView.addGestureRecognizer(dismissTap)
    }
}

//MARK: - 事件监听
extension LFPopoverPresentationController {
    @objc fileprivate func dismiss() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
