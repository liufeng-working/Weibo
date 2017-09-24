//
//  LFStatusCell.swift
//  WeiBo
//
//  Created by 刘丰 on 2017/9/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

import UIKit

class LFStatusCell: UITableViewCell {

    static func statusCell(tableView: UITableView) -> LFStatusCell {
        let lf_LFStatusCell_id = "LFStatusCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: lf_LFStatusCell_id) as? LFStatusCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("LFStatusCell", owner: nil, options: nil)?.first as? LFStatusCell
        }
        return cell!
    }
}
