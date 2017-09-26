//
//  LFStatusCell.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit
import SDWebImage

private let lf_picView_lrMargin: CGFloat = 15
private let lf_picView_margin: CGFloat = 10
class LFStatusCell: UITableViewCell {
    
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var verifiedView: UIImageView!
    @IBOutlet private weak var nameL: UILabel!
    @IBOutlet private weak var vipView: UIImageView!
    @IBOutlet private weak var timeL: UILabel!
    @IBOutlet private weak var sourceL: UILabel!
    @IBOutlet private weak var textL: UILabel!
    @IBOutlet weak var retweetTextL: UILabel!
    @IBOutlet weak var retweetBgView: UIView!
    
    @IBOutlet weak var picView: LFPictureView!
    @IBOutlet weak var picViewWidthC: NSLayoutConstraint!
    @IBOutlet weak var picViewHeightC: NSLayoutConstraint!
    @IBOutlet weak var picViewLeftC: NSLayoutConstraint!
    @IBOutlet weak var picViewBottomC: NSLayoutConstraint!
    @IBOutlet weak var retweetTextTopC: NSLayoutConstraint!
    
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var unlikeBtn: UIButton!
    
    var statusM: LFStatusModel? {
        didSet {
            if let statusM = self.statusM {
                self.iconView.sd_setImage(with: statusM.user?.profile_image_url_url, placeholderImage: UIImage(named: "avatar_default_small"), options: SDWebImageOptions.retryFailed)
                self.verifiedView.image = statusM.user?.verified_image
                self.nameL.text = statusM.user?.screen_name
                self.vipView.image = statusM.user?.mbrank_image
                self.timeL.text = statusM.created_at_str
                self.sourceL.text = statusM.source_str
                self.textL.text = statusM.text
                self.nameL.textColor = statusM.user?.mbrank == 0 ? UIColor.black : UIColor.orange
                
                self.retweetBtn.setTitle(statusM.reposts_str, for: UIControlState.normal)
                commentBtn.setTitle(statusM.comments_str, for: UIControlState.normal)
                unlikeBtn.setTitle(statusM.attitudes_str, for: UIControlState.normal)
                
                if statusM.hasRetweet {
                    self.retweetTextL.text = "@\(statusM.retweeted_status!.user!.screen_name!) :" + statusM.retweeted_status!.text!
                    self.retweetBgView.isHidden = false
                    self.retweetTextTopC.constant = 20
                }else {
                    self.retweetTextL.text = nil
                    self.retweetBgView.isHidden = true
                    self.retweetTextTopC.constant = 0
                }
                
                self.setupPictureView()
            }
        }
    }

    static func statusCell(tableView: UITableView) -> LFStatusCell {
        let lf_LFStatusCell_id = "LFStatusCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: lf_LFStatusCell_id) as? LFStatusCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("LFStatusCell", owner: nil, options: nil)?.first as? LFStatusCell
        }
        return cell!
    }
    
    //设置配图view
    private func setupPictureView() {
        self.picViewLeftC.constant = lf_picView_lrMargin
        
        var pic_width: CGFloat = 1
        var pic_height: CGFloat = 1
        var picView_width: CGFloat = lfScreenWidth - 2*lf_picView_lrMargin
        var picView_height: CGFloat = 0
        var picView_bottomConstant: CGFloat = 10
        
        let count = (self.statusM?.pic_urls.count)!
        if count == 0 || count > 9 {
            picView_bottomConstant = 0
        }else if count == 1 {
            if let img = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: self.statusM?.pic_urls.first?.bmiddle_pic_url?.absoluteString) {
                let targetSize = LFFit.fitSize(originalSize: img.size, targetWidth: picView_width)
                picView_width = targetSize.width
                picView_height = targetSize.height
                pic_width = targetSize.width
                pic_height = targetSize.height
            }
        }else if count == 4 {
            pic_width = (picView_width - 2*lf_picView_margin)/3
            pic_height = pic_width
            picView_height = 2*pic_width + lf_picView_margin
            picView_width = picView_height
        }else {
            pic_width = (picView_width - 2*lf_picView_margin)/3
            pic_height = pic_width
            let row = CGFloat((count - 1)/3 + 1)
            picView_height = row*pic_width + (row - 1)*lf_picView_margin
        }
        
        let layout = self.picView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: pic_width, height: pic_height)
        
        self.picView.picMs = (self.statusM?.pic_urls)!
        self.picViewWidthC.constant = picView_width
        self.picViewHeightC.constant = picView_height
        self.picViewBottomC.constant = picView_bottomConstant
    }
}
