//
//  TabBarController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension TabBarController {
    func configure() {
        let newsHomeVC = UINavigationController(rootViewController: MainViewController())
        newsHomeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "Home"),
            selectedImage: UIImage(systemName: "Home")
            
        )
        
        let newsSearchVC = UINavigationController(rootViewController: MyPageViewController())
        newsSearchVC.tabBarItem = UITabBarItem(
            title: "MyPage",
            image: UIImage(named: "Frame"),
            selectedImage: UIImage(systemName: "Frame")
        )
        viewControllers = [newsHomeVC, newsSearchVC]
        //tabBar.tintColor = .systemPink
        
        TabbarApperance()
    }
    
    func TabbarApperance() {
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().backgroundColor = .black
        
        
    }
}
