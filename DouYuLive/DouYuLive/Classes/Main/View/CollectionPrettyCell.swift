//
//  CollectionPrettyCell.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/9.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class CollectionPrettyCell: BaseCollectionViewCell {
    
    @IBOutlet weak var cityBtn: UIButton!

    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: UIControlState.normal)
            
        }
    }
}
