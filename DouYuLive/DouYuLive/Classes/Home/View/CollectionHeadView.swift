//
//  CollectionHeadView.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/9/29.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class CollectionHeadView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension CollectionHeadView {
    class func collectionHeaderView() -> CollectionHeadView {
        return Bundle.main.loadNibNamed("CollectionHeadView", owner: nil, options: nil)?.first as! CollectionHeadView
    }
}
