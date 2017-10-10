//
//  RecommandViewModel.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/9.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class RecommandViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var hotData : AnchorGroup = AnchorGroup()
    lazy var prettyData : AnchorGroup = AnchorGroup()
    
    lazy var cycleModels : [CycleModel] = [CycleModel]()
}

extension RecommandViewModel {
    func requestData(finishedCallBack : @escaping () -> ()) {
        
        let disGroup = DispatchGroup()
        
        //热门
        disGroup.enter()
        NetworkTools.requestData(type: MethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            self.hotData.tag_name = "热门"
            self.hotData.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.hotData.anchors.append(anchor)
            }
            
            disGroup.leave()
        }
        
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        //颜值
        disGroup.enter()
        NetworkTools.requestData(type: MethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameters: parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            self.prettyData.tag_name = "颜值"
            self.prettyData.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyData.anchors.append(anchor)
            }
            
            disGroup.leave()
        }
        
        //热门
        disGroup.enter()
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1507532912
//        print(NSDate.getCurrentTime())
        NetworkTools.requestData(type: MethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
//            for group in self.anchorGroups {
//                print(group.tag_name)
//                for anchor in group.anchors {
//                    print(anchor.nickname)
//                }
//                print("----------------")
//            }
            
            disGroup.leave()
        }
        
        //所有请求结束，进行数据排序
        disGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyData, at: 0)
            self.anchorGroups.insert(self.hotData, at: 0)
            
            finishedCallBack()
        }
    }
    
    func requsetCycleData(finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(type: MethodType.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishedCallBack()
        }
    }
}
