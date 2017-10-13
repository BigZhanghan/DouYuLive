//
//  GameViewModel.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/12.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}


extension GameViewModel {
    func loadGameData(finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            for dict in dataArray { 
                self.games.append(GameModel(dict: dict))
            }
            
            finishedCallBack()
        }
    }
}
