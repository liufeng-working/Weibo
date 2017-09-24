//
//  LFBaseViewController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFBaseViewController: UITableViewController {
    
    var isLogin = LFOAuthViewModel.shareOAuth.isLogin
    lazy var visitorView: LFVisitorView = LFVisitorView.visitorView()
    
    override func loadView() {
        self.isLogin ? super.loadView() : self.setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !self.isLogin {
            
            self.setupNavigationBarDefault()
            self.visitorView.rotationViewAnimation()
        }else {
            self.setupNavigationBarCustom()
        }
    }
}

//MARK: - 设置UI
extension LFBaseViewController {
    func setupVisitorView() {
        self.view = self.visitorView
        self.visitorView.delegate = self
    }
    
    func setupNavigationBarDefault() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(registorItemClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(loginItemClick))
    }
    
    func setupNavigationBarCustom() {
        //子类重写
    }
}

//MARK: - 事件监听
extension LFBaseViewController {
    func registorItemClick() {
        print(#function)
    }
    
    func loginItemClick() {
        let oauthVC = LFOAuthViewController()
        let oauthNav = LFNavigationController(rootViewController: oauthVC)
        self.present(oauthNav, animated: true, completion: nil)
    }
}

//MARK: - LFVisitorViewDelegate
extension LFBaseViewController: LFVisitorViewDelegate {
    func registorClick(visitorView: LFVisitorView) {
        self.registorItemClick()
    }
    
    func loginClick(visitorView: LFVisitorView) {
        self.loginItemClick()
    }
}
