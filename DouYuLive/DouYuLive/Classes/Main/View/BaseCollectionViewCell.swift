//
//  BaseCollectionViewCell.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/9.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            var onlineCount :  String = ""
            if anchor.online >= 10000 {
                onlineCount = "\(Int(anchor.online / 1000))万在线"
            } else {
                onlineCount = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineCount, for: UIControlState.normal)
            
            nicknameLabel.text = anchor.nickname
            
            guard let iconURL = URL(string : anchor.vertical_src) else {
                return
            }
            sourceImageView.kf.setImage(with: iconURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
