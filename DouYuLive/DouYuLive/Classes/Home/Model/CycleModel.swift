//
//  CycleModel.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/10.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var title : String = ""
    var pic_url : String = ""
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    var anchor : AnchorModel?
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
