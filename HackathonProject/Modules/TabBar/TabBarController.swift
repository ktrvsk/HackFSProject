//
//  TabBarController.swift
//  HackathonProject
//
//  Created by Ksusha on 18.07.2022.
//

import Foundation
import UIKit

protocol TabBarControllerProtocol: UIViewController {}

final class TabBarController: UITabBarController, TabBarControllerProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func settingController(for rootController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        tabBar.tintColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        return navigationController
    }

    private func setupTabBar() {
        viewControllers = [
            settingController(for: TokenBalanceController(), title: "Token", image: UIImage(systemName: "circle")),
            settingController(for: NFTBalanceController(), title: "NFT", image: UIImage(systemName: "photo")),
            settingController(for: ProfileController(), title: "Profile", image: UIImage(systemName: "person")),
        ]
    }
}
