//
//  LFOAuthViewController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//  微博授权控制器

import UIKit
import SVProgressHUD

class LFOAuthViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBarCustom()
        self.loadWebPage()
    }
}

//MARK: - UI
extension LFOAuthViewController {
    fileprivate  func setupNavigationBarCustom() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(close))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: UIBarButtonItemStyle.plain, target: self, action: #selector(fill))
        
        self.navigationItem.title = "授权"
    }
    
    fileprivate func loadWebPage() {
        let urlStr = "\(weibo_oauth_authorize)?client_id=\(weibo_oauth_appKey)&redirect_uri=\(weibo_oauth_redirectUrl)"
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        self.webView.loadRequest(request)
    }
}

//MARK: - 事件监听
extension LFOAuthViewController {
    @objc fileprivate func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func fill() {
        let jsCode = "document.getElementById('userId').value='\(weibo_userName)';document.getElementById('passwd').value='\(weibo_password)';"
        self.webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

//MARK: - 请求数据
extension LFOAuthViewController {
    fileprivate func loadAccessToken(code: String) {
        
        LFOAuthViewModel.loadAccessToken(code: code, success: { (oauth: LFOAuth) in
            
            //保存到本地
            NSKeyedArchiver.archiveRootObject(oauth, toFile: LFOAuthViewModel.shareOAuth.oauthPath)
            LFOAuthViewModel.shareOAuth.oauth = oauth
            
            self.loadUserInfo(oauth: oauth)
        }) { (error: Error) in
            
        }
    }
    
    fileprivate func loadUserInfo(oauth: LFOAuth) {
        LFOAuthViewModel.loaduserInfo(accessToken: oauth.access_token!, uid: oauth.uid!, success: { (user: LFUser) in
            
            //保存到本地
            NSKeyedArchiver.archiveRootObject(user, toFile: LFUserViewModel.shareUser.userPath)
            LFUserViewModel.shareUser.user = user
            
            //退出认证页
            self.dismiss(animated: false, completion: {
                //显示欢迎页
                lfWindow.rootViewController = lfWelcomeVC
            })
        }) { (error: Error) in
            
        }
    }
}

//MARK: - UIWebViewDelegate
extension LFOAuthViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else {
            return true
        }
        
        let urlStr = url.absoluteString
        guard urlStr.contains("code=") else {
            return true
        }
        
        let strs = urlStr.components(separatedBy: "code=")
        guard let code = strs.last else {
            return true
        }
        
        self.loadAccessToken(code: code)
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
}
