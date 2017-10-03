//
//  LFHomeViewController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class LFHomeViewController: LFBaseViewController {
    
    fileprivate lazy var statusMs = [LFStatusModel]()

    //MARK: - titleView
    fileprivate lazy var titleView: LFTitleButton = {
        let titleBtn = LFTitleButton()
        titleBtn.addTarget(self, action: #selector(titleViewClick), for: UIControlEvents.touchUpInside)
        return titleBtn
    }()
    
    fileprivate lazy var popoverAnimation: LFPopoverAnimation = {
        let popoverA = LFPopoverAnimation()
        popoverA.dismissCallback = {
            self.titleView.isSelected = !self.titleView.isSelected
        }
        return popoverA
    }()
    
    fileprivate lazy var tipView: UILabel = {
        let tip = UILabel(frame: CGRect(x: 0, y: 34, width: self.view.bounds.width, height: 30))
        tip.backgroundColor = UIColor.orange
        tip.textColor = UIColor.white
        tip.font = UIFont.systemFont(ofSize: 14)
        tip.textAlignment = NSTextAlignment.center
        tip.isHidden = true
        return tip
    }()

    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRefreshView()
    }
    
    override func viewDidLayoutSubviews() {
        self.view.superview?.addSubview(self.tipView)
    }
}

//MARK: - UI
extension LFHomeViewController {
    override func setupNavigationBarCustom() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageNamed: "navigationbar_friendattention", highlightedImageNamed: "navigationbar_friendattention_highlighted")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(imageNamed: "navigationbar_pop", highlightedImageNamed: "navigationbar_pop_highlighted")
        self.titleView.setTitle(LFUserViewModel.shareUser.user?.screen_name, for: UIControlState.normal)
        self.navigationItem.titleView = self.titleView
    }
    
    fileprivate func setupRefreshView() {
        let refHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadHomeData))
        refHeader?.setTitle("下拉刷新", for: MJRefreshState.idle)
        refHeader?.setTitle("释放立即刷新", for: MJRefreshState.willRefresh)
        refHeader?.setTitle("正在刷新", for: MJRefreshState.refreshing)
        self.tableView.mj_header = refHeader
        refHeader?.beginRefreshing()
        
        let refFooter = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreHomeData))
        refFooter?.setTitle("上拉加载更多", for: MJRefreshState.idle)
        refFooter?.setTitle("释放立即加载", for: MJRefreshState.willRefresh)
        refFooter?.setTitle("正在加载", for: MJRefreshState.refreshing)
        self.tableView.mj_footer = refFooter
    }
}

//MARK: - 事件监听
extension LFHomeViewController {
    @objc fileprivate func titleViewClick(titleBtn: LFTitleButton) {
        titleBtn.isSelected = !titleBtn.isSelected
        
        let popoverVC = LFPopoverViewController()
        popoverVC.transitioningDelegate = self.popoverAnimation
        self.present(popoverVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func loadHomeData() {
        self.loadHomeTimeline(isNew: true)
    }
    
    @objc fileprivate func loadMoreHomeData() {
        self.loadHomeTimeline(isNew: false)
    }
}

//MARK: - 请求数据
extension LFHomeViewController {
    fileprivate func loadHomeTimeline(isNew: Bool) {
        var since_id = 0
        var max_id = 0
        if isNew {
            since_id = self.statusMs.first?.mid ?? 0
        }else {
            max_id = self.statusMs.last?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        LFHomeViewModel.loadHomeTimeline(since_id: since_id, max_id: max_id, success: { (statusMs: [LFStatusModel]) in
            
            //缓存只有一张配图的图片
            let group = DispatchGroup()
            for statusM in statusMs {
                if statusM.pic_urls.count == 1 {
                    group.enter()
                    SDWebImageManager.shared().loadImage(with: statusM.pic_urls.first?.bmiddle_pic_url, options: SDWebImageOptions.retryFailed, progress: nil, completed: { (_, _, _, _, _, _) in
                        group.leave()
                    })
                }
            }
            
            //刷新表格
            group.notify(queue: DispatchQueue.main, execute: {
                self.showTipView(count: statusMs.count)
                if isNew {
                    self.statusMs.insert(contentsOf: statusMs, at: 0)
                    self.tableView.mj_header.endRefreshing()
                }else {
                    self.statusMs.append(contentsOf: statusMs)
                    self.tableView.mj_footer.endRefreshing()
                }
                self.tableView.reloadData()
            })
        }) { (error: Error) in
            if isNew {
                self.tableView.mj_header.endRefreshing()
            }else {
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
}

//MARK: - 其他方法
extension LFHomeViewController {
    
    //展示新数据提示的view
    fileprivate func showTipView(count: Int) {
        self.tipView.isHidden = false
        self.tipView.text = count == 0 ? "没有新数据" : "\(count)条新数据"
        UIView.animate(withDuration: 1, animations: { 
            self.tipView.frame.origin.y = 64
        }) { (_) in
            UIView.animate(withDuration: 1, delay: 1, options: [], animations: { 
                self.tipView.frame.origin.y = 34
            }, completion: { (_) in
                self.tipView.isHidden = true
            })
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension LFHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusMs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LFStatusCell.statusCell(tableView: tableView)
        cell.statusM = self.statusMs[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
