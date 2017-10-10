//
//  LFEmoticonViewController.swift
//  Emotcion
//
//  Created by 刘丰 on 2017/10/9.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

private let LFEmoticonCell_id = "LFEmoticonCell"
class LFEmoticonViewController: UIViewController {
    
    lazy var manager = LFEmoticonManager.shareManager
    fileprivate var emoticonCallback: (_ emoticon: LFEmoticon) -> ()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    fileprivate lazy var toolView: UIToolbar = {
        var items = [UIBarButtonItem]()
        var index = 0
        for title in ["最近", "默认", "emoji", "浪小花"] {
            let item = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action: #selector(itemClick(item:)))
            item.tag = index
            items.append(item)
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil))
            index += 1
        }
        items.removeLast()
        let toolView = UIToolbar()
        toolView.items = items
        toolView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toolView)
        return toolView
    }()
    
    init(emoticonCallback: @escaping (_ emoticon: LFEmoticon) -> ()) {
        self.emoticonCallback = emoticonCallback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.prepareCollectionView()
    }
}

//MARK: - 设置UI
extension LFEmoticonViewController {
    fileprivate func setupUI() {
        let views: [String: Any] = ["collectionView": self.collectionView, "toolView": self.toolView]
        
        let hCon = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views)
        self.view.addConstraints(hCon)
        
        let vCon = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-[toolView]-0-|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        self.view.addConstraints(vCon)
    }
    
    fileprivate func prepareCollectionView() {
        self.collectionView.register(LFEmoticonCell.classForCoder(), forCellWithReuseIdentifier: LFEmoticonCell_id)
    }
}

//MARK: - 事件
extension LFEmoticonViewController {
    @objc fileprivate func itemClick(item: UIBarButtonItem) {
        let indexPath = IndexPath(item: 0, section: item.tag)
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
        
    }
}

//MARK: - 私有方法
extension LFEmoticonViewController {
    fileprivate func insertRecentlyEmoticon(emoticon: LFEmoticon) {
        if emoticon.isRemove || emoticon.isEmpty {
            return
        }
        
        if self.manager.packages.first!.emoticons.contains(emoticon) {
            self.manager.packages.first!.emoticons.remove(at: self.manager.packages.first!.emoticons.index(of: emoticon)!)
        }else {
            self.manager.packages.first!.emoticons.remove(at: 19)
        }
        
        self.manager.packages.first!.emoticons.insert(emoticon, at: 0)
    }
}

//MARK: - UICollectionDataSource
extension LFEmoticonViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.manager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.manager.packages[section].emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LFEmoticonCell_id, for: indexPath) as! LFEmoticonCell
        cell.emoticon = self.manager.packages[indexPath.section].emoticons[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoticon = self.manager.packages[indexPath.section].emoticons[indexPath.item]
        self.insertRecentlyEmoticon(emoticon: emoticon)
        collectionView.reloadSections(IndexSet(integer: 0))
        self.emoticonCallback(emoticon)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/7, height: collectionView.frame.height/3)
    }
}
