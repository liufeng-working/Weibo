//
//  LFPopoverAnimation.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFPopoverAnimation: NSObject {
    
    var presentedViewFrame = CGRect(x: 100, y: 60, width: 180, height: 250)
    
    var dismissCallback: (() -> ())?
    var presentedCallback: (() -> ())?
}

//MARK: - UIViewControllerTransitioningDelegate
extension LFPopoverAnimation: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let popoverPresentationC = LFPopoverPresentationController(presentedViewController: presented, presenting: presenting)
        popoverPresentationC.presentedViewFrame = self.presentedViewFrame
        return popoverPresentationC
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self;
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

//MARK: - UIViewControllerAnimatedTransitioning
extension LFPopoverAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        var presentedVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        if let _ = presentedVC.presentedViewController {
            if (presentedVC.presentedViewController?.isBeingPresented)! {
                let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
                
                transitionContext.containerView.addSubview(presentedView)
                
                presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
                presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
                UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                    presentedView.transform = CGAffineTransform.identity
                }) { (isFinished: Bool) -> () in
                    transitionContext.completeTransition(isFinished)
                    self.presentedCallback?()
                }
            }
        }else {
            presentedVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            if (presentedVC.presentedViewController?.isBeingDismissed)! {
                let presentingView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
                
                presentingView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
                UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                    presentingView.transform = CGAffineTransform(scaleX: 1.0, y: 1e-20)
                }) { (isFinished: Bool) -> () in
                    presentingView.removeFromSuperview()
                    transitionContext.completeTransition(isFinished)
                    self.dismissCallback?()
                }
            }
        }
    }
}
