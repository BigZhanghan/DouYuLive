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

let StatusBarH : CGFloat = 20;
let NavigationBarH :CGFloat = 44;


extension UIColor
{
    //主色值
    class func mainColor() -> UIColor {
        return UIColor.init(colorLiteralRed: 253/255.0, green: 119/255.0, blue: 34/255.0, alpha: 1.0);
    }
}
