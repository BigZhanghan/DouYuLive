//
//  HomeViewController.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/9/28.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

private let titleViewH : CGFloat = 40;

class HomeViewController: UIViewController {
    lazy var pageContentView : PageContentView = {[weak self] in
        let contentH : CGFloat = Screen_height - StatusBarH - NavigationBarH - titleViewH - TabBarH
        let contentFrame = CGRect(x: 0, y: StatusBarH + NavigationBarH + titleViewH, width: Screen_width, height: contentH)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommandViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: 64, width: Screen_width, height: titleViewH);
        let titles = ["推荐", "游戏", "娱乐", "趣玩"];
        let titleView = PageTitleView(frame: titleFrame, titles: titles);
        titleView.delegate = self
        return titleView;
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

//mark - 设置UI界面
extension HomeViewController {
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar();
    
        view.addSubview(pageTitleView);
        
        view.addSubview(pageContentView)
    }
    
    func setupNavigationBar () {
        //leftBarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo");
        
        //rightBarButtonItems
        let size = CGSize.init(width: 35, height: 35);
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size);
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size);
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size);
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];
    }
}

extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
