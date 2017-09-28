//
//  MainTabBarController.swift
//  DouYuLive
//
//  Created by zhanghan on 2017/9/28.
//  Copyright © 2017年 zhanghan. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建TabBar
        self.addChildVc(storyName: "Home");
        self.addChildVc(storyName: "Live");
        self.addChildVc(storyName: "Follow");
        self.addChildVc(storyName: "Mine");
        //修改TabBar颜色
        self.setupTabBarItemAppearance();

        // Do any additional setup after loading the view.
    }

    func setupTabBarItemAppearance ()
    {
        self.tabBar.tintColor = UIColor.mainColor();
        for item in self.tabBar.items! {
            item.image = item.image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
            item.selectedImage = item.selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        }
    }
    
    func addChildVc(storyName:String) {
        let childVc = UIStoryboard(name:storyName, bundle:nil).instantiateInitialViewController()!;
        self.addChildViewController(childVc);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
