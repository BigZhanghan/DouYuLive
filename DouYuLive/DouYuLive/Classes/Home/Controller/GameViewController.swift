//
//  GameViewController.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/10/11.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

private let kEdgeMarginW : CGFloat = 10
private let kItemW : CGFloat = (Screen_width - kEdgeMarginW * 2) / 3
private let kItemH : CGFloat = kItemW * 6 / 5

private let kGameCellId = "kGameCellId"

class GameViewController: UIViewController {

    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMarginW, bottom: 0, right: kEdgeMarginW)
        
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

extension GameViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

extension GameViewController {
    func loadData() {
        gameVM.loadGameData { 
            self.collectionView.reloadData()
        }
    }
}

extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let game = gameVM.games[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! GameCollectionViewCell
        cell.baseGame = game
//        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}



