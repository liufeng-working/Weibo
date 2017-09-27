//
//  LFAddPhotoView.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/28.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFAddPhotoView: UICollectionView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dataSource = self
        self.delegate = self
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension LFAddPhotoView: UICollectionViewDelegate, UICollectionViewDataSource {
    
}
