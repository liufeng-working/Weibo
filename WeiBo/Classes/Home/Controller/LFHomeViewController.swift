//
//  LFHomeViewController.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFHomeViewController: LFBaseViewController {
    
    lazy var statusMs = [LFStatusModel]()

    //MARK: - titleView
    lazy var titleView: LFTitleButton = {
        let titleBtn = LFTitleButton()
        titleBtn.addTarget(self, action: #selector(titleViewClick), for: UIControlEvents.touchUpInside)
        return titleBtn
    }()
    
    lazy var popoverAnimation: LFPopoverAnimation = {
        let popoverA = LFPopoverAnimation()
        popoverA.dismissCallback = {
            self.titleView.isSelected = !self.titleView.isSelected
        }
        return popoverA
    }()

    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadHomeTimeline()
    }
}

//MARK: - UI
extension LFHomeViewController {
    override func setupNavigationBarCustom() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageNamed: "navigationbar_friendattention", highlightedImageNamed: "navigationbar_friendattention_highlighted")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(imageNamed: "navigationbar_pop", highlightedImageNamed: "navigationbar_pop_highlighted")
        
        self.titleView.setTitle("时间再久也不会忘记你的样子", for: UIControlState.normal)
        self.navigationItem.titleView = self.titleView
    }
}

//MARK: - 事件监听
extension LFHomeViewController {
    func titleViewClick(titleBtn: LFTitleButton) {
        titleBtn.isSelected = !titleBtn.isSelected
        
        let popoverVC = LFPopoverViewController()
        popoverVC.transitioningDelegate = self.popoverAnimation
        self.present(popoverVC, animated: true, completion: nil)
    }
}

//MARK: - 请求数据
extension LFHomeViewController {
    func loadHomeTimeline() {
        LFHomeViewModel.loadHomeTimeline(success: { (statusMs: [LFStatusModel]) in
            self.statusMs = statusMs
            self.tableView.reloadData()
        }) { (error: Error) in
            
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
