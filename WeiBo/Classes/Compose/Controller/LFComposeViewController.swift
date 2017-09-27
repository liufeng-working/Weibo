//
//  LFComposeViewController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFComposeViewController: UIViewController {
    
    @IBOutlet fileprivate weak var textView: LFTextView!
    @IBOutlet fileprivate weak var toolViewBottomC: NSLayoutConstraint!
    @IBOutlet weak var picPickerViewHeightC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
}

//MARK: - 设置UI
extension LFComposeViewController {
    func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.plain, target: self, action: #selector(sendClick))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.title = "发微博"
    }
    
    //监听键盘
    func keyboardWillChangeFrame(noti: Notification) {
        //UIKeyboardAnimationDurationUserInfoKey
        //UIKeyboardFrameEndUserInfoKey
        let duration = noti.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let kbY = (noti.userInfo?["UIKeyboardFrameEndUserInfoKey"] as! CGRect).minY
        self.toolViewBottomC.constant = self.view.bounds.height - kbY
        UIView.animate(withDuration: duration) { 
            self.view.setNeedsLayout()
        }
    }
    
    @IBAction func picturePicker() {
        self.textView.resignFirstResponder()
        self.picPickerViewHeightC.constant = self.view.bounds.height*0.6
        UIView.animate(withDuration: 0.25) { 
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - 事件监听
extension LFComposeViewController {
    func closeClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendClick() {
        
    }
    
    
}

//MARK: - UITextViewDelegate
extension LFComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}
