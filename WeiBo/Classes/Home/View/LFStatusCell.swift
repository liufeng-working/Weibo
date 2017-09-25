//
//  LFStatusCell.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit
import SDWebImage

class LFStatusCell: UITableViewCell {
    
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var verifiedView: UIImageView!
    @IBOutlet private weak var nameL: UILabel!
    @IBOutlet private weak var vipView: UIImageView!
    @IBOutlet private weak var timeL: UILabel!
    @IBOutlet private weak var sourceL: UILabel!
    @IBOutlet private weak var textL: UILabel!
    
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
}
