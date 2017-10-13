//
//  common.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/9/28.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

//screen_size
let Screen_width : CGFloat = UIScreen.main.bounds.size.width;
let Screen_height : CGFloat = UIScreen.main.bounds.size.height;

let StatusBarH : CGFloat = 20
let NavigationBarH :CGFloat = 44
let TabBarH : CGFloat = 49


extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}


