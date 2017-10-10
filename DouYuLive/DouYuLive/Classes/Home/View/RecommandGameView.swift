//
//  RecommandGameView.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/10.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

private let GameCellId = "GameCellId"
private let EdgeInsetMargin : CGFloat = 10

class RecommandGameView: UIView {
    
    var groups : [AnchorGroup]? {
        didSet {
            groups?.removeFirst()
            groups?.removeFirst()
            
            //添加更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GameCellId)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: EdgeInsetMargin, bottom: 0, right: EdgeInsetMargin)
    }
}

extension RecommandGameView {
    class func recommandGameView() -> RecommandGameView {
        return Bundle.main.loadNibNamed("RecommandGameView", owner: nil, options: nil)?.first as! RecommandGameView
    }
}

extension RecommandGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = groups![indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCellId, for: indexPath) as! GameCollectionViewCell
        
        cell.group = group
        
        return cell
    }
}
