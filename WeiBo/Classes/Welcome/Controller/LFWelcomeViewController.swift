//
//  LFWelcomeViewController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//  欢迎页面

import UIKit
import SDWebImage

class LFWelcomeViewController: UIViewController {
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var iconViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.iconView.sd_setImage(with: URL(string: LFUserViewModel.shareUser.user?.avatar_large ?? ""), placeholderImage: UIImage(named: "avatar_default_big"), options: SDWebImageOptions.retryFailed)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.iconViewBottomConstraint.constant = self.view.frame.size.height*0.7;
        UIView.animate(withDuration: 2.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }) { (finish: Bool) in
            lfWindow.rootViewController = lfMainVC
        }
    }
}
