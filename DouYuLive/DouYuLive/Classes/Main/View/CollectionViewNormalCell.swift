//
//  CollectionViewNormalCell.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/9.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: BaseCollectionViewCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
}
