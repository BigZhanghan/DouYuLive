//
//  extension.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/9/28.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}

extension UIBarButtonItem {
    /*便利构造函数
     1>convenience开头
     2>构造函数中必须明确d调用一个设计函数（self）
     */
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton();
        btn .setImage(UIImage.init(named: imageName), for: UIControlState.normal);
        if highImageName != "" {
            btn.setImage(UIImage.init(named: highImageName), for: UIControlState.highlighted);
        }
        if size == CGSize.zero {
            btn.sizeToFit();
        } else {
            btn.frame = CGRect.init(origin: CGPoint.zero, size: size);
        }
        self.init(customView: btn);
    }
}


