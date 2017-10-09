//
//  NetworkTools.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/9.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case post
    case get
}

class NetworkTools {
    class func requestData(type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishCallBack : @escaping(_ result : Any) -> ()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            finishCallBack(result : result)
        }
    }
}
