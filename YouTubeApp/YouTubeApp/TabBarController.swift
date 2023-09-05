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
            title: "Main",
            image: UIImage(systemName: ""),
            selectedImage: UIImage(systemName: "")
        )
        
        let newsSearchVC = UINavigationController(rootViewController: MyPageViewController())
        newsSearchVC.tabBarItem = UITabBarItem(
            title: "Info",
            image: UIImage(systemName: ""),
            selectedImage: UIImage(systemName: "")
        )
        viewControllers = [newsHomeVC, newsSearchVC]
        tabBar.tintColor = .systemPink
    }
}
