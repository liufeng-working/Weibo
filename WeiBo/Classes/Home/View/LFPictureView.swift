//
//  LFPictureView.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/26.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

private let lfPictureView_id = "LFPictureCell"

class LFPictureView: UICollectionView {
    
    var picMs: [LFPicture] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.dataSource = self
        self.delegate = self
        
        self.register(UINib(nibName: lfPictureView_id, bundle: nil), forCellWithReuseIdentifier: lfPictureView_id)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension LFPictureView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.picMs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lfPictureView_id, for: indexPath) as! LFPictureCell
        cell.picM = self.picMs[indexPath.row]
        return cell
    }
}
