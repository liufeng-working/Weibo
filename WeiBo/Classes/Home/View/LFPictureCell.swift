//
//  LFPictureCell.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/26.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit
import SDWebImage

class LFPictureCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!

    var picM: LFPicture? {
        didSet {
            self.imageView.sd_setImage(with: self.picM?.bmiddle_pic_url, placeholderImage: nil, options: SDWebImageOptions.retryFailed)
        }
    }
}
