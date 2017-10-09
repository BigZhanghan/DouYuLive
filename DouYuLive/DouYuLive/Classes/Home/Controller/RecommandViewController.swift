//
//  RecommandViewController.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/9/29.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

private let itemMargin : CGFloat = 10
private let itemW = (Screen_width - itemMargin * 3) / 2
private let NormalItemH = itemW * 3 / 4
private let PrettyItemH = itemW * 4 / 3
private let NormalCellId = "NormalCellId"
private let PrettyCellId = "PrettyCellId"
private let headViewH : CGFloat = 50
private let HeadViewId = "HeadViewId"

class RecommandViewController: UIViewController {

    lazy var recommandVM : RecommandViewModel = RecommandViewModel()
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: itemW, height: NormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: Screen_width, height: headViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, itemMargin, 0, itemMargin)
        
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: NormalCellId)
        
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: PrettyCellId)
        
        collectionView.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeadViewId)
        return collectionView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        requestData()
    }
}

extension RecommandViewController {
    func setupUI() {
        view.addSubview(collectionView)
    }
}

extension RecommandViewController {
    func requestData() {
        recommandVM.requestData()
    }
}

extension RecommandViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrettyCellId, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellId, for: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeadViewId, for: indexPath)
        
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: itemW, height: PrettyItemH)
        } else {
            return CGSize(width: itemW, height: NormalItemH)
        }
        
    }
}



