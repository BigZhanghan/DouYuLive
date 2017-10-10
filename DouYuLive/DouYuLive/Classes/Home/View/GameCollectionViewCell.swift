//
//  GameCollectionViewCell.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/10.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            
            let iconURL = URL(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
