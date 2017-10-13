//
//  BaseGameModel.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/12.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    var tag_name : String = ""
    var icon_url : String = ""
    
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
