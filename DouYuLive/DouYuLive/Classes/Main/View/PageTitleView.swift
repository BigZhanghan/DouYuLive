//
//  PageTitleView.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/9/28.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectIndex index : Int)
}

private let ScrollLineH : CGFloat = 2
private let NormalColor : (CGFloat, CGFloat, CGFloat) = (85,85,85)
private let SelectColor : (CGFloat, CGFloat, CGFloat) = (253,119,34)

class PageTitleView: UIView {
    var titles : [String];
    var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?

    lazy var titleLabels : [UILabel] = [UILabel]()
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.mainColor()
        return scrollLine
    }()
    
    init(frame : CGRect, titles : [String]) {
        self.titles = titles;
        super.init(frame: frame);
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PageTitleView {
    func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds;
        
        setTitleLabels();
        
        setupBottomLine()
    }
    
    private func setTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - ScrollLineH;
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel();
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: NormalColor.0, g: NormalColor.1, b: NormalColor.2)
            label.textAlignment = .center
            
            let labelX : CGFloat = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelTap(tap:)))
            label.addGestureRecognizer(tapGesture)
        }
    }
    
    private func setupBottomLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.mainColor() 
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y:frame.height - ScrollLineH, width: firstLabel.frame.width, height: ScrollLineH)
    }
}

extension PageTitleView {
    func titleLabelTap(tap:UITapGestureRecognizer) {
        guard let currentLabel = tap.view as? UILabel else {
            return
        }
        let oldLabel = titleLabels[currentIndex]
        currentLabel.textColor = UIColor.mainColor()
        oldLabel.textColor = UIColor(r: NormalColor.0, g: NormalColor.1, b: NormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
}

//Public-Method
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotal = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = progress * moveTotal
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorDelte = (SelectColor.0 - NormalColor.0, SelectColor.1 - NormalColor.1, SelectColor.2 - NormalColor.2)
        sourceLabel.textColor = UIColor(r: SelectColor.0 - colorDelte.0 * progress, g: SelectColor.1 - colorDelte.1 * progress, b: SelectColor.2 - colorDelte.2 * progress)
        targetLabel.textColor = UIColor(r: NormalColor.0 + colorDelte.0 * progress, g: NormalColor.1 + colorDelte.1 * progress, b: NormalColor.2 + colorDelte.2 * progress)
        
        currentIndex = targetIndex
    }
}



