//
//  PageContentView.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/9/28.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(pageContentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellId = "ContentCellId"

class PageContentView: UIView {
    var childVcs : [UIViewController]
    weak var parentVc : UIViewController?
    var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    var isForbidScrollDelegate : Bool = false
    
    lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:ContentCellId)
        
        return collectionView
    }()
    
    init(frame : CGRect, childVcs : [UIViewController], parentVc : UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    func setupUI() {
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.frame
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {
            return
        }
    
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX : CGFloat = scrollView.contentOffset.x
        if currentOffsetX > startOffsetX {//左滑
            progress = currentOffsetX / scrollView.bounds.width - floor(currentOffsetX / scrollView.bounds.width)
            sourceIndex = Int(currentOffsetX / scrollView.bounds.width)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if currentOffsetX - startOffsetX > 0 && currentOffsetX.truncatingRemainder(dividingBy: scrollView.frame.width) == 0  {
                progress = 1.0
                targetIndex = sourceIndex
            }
        } else {
            progress = 1 - (currentOffsetX / scrollView.bounds.width - floor(currentOffsetX / scrollView.bounds.width))
            targetIndex = Int(currentOffsetX / scrollView.bounds.width)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

//Public-Method
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
}

