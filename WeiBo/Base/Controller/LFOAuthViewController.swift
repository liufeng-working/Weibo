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
        self.loadPage()
    }
}

//MARK: - UI
extension LFOAuthViewController {
    func setupNavigationBarCustom() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(close))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: UIBarButtonItemStyle.plain, target: self, action: #selector(fill))
        
        self.navigationItem.title = "授权"
    }
    
    func loadPage() {
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(weibo_oauth_appKey)&redirect_uri=\(weibo_oauth_redirectUrl)"
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        self.webView.loadRequest(request)
    }
}

//MARK: - 事件监听
extension LFOAuthViewController {
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fill() {
        let jsCode = "document.getElementById('userId').value='1483682940@qq.com';document.getElementById('passwd').value='A';"
        self.webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

//MARK: - UIWebViewDelegate
extension LFOAuthViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.showError(withStatus: "加载失败，稍后重试")
    }
}
