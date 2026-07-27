//
//  MainTabBarController.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {

    private let homeRootView: AnyView

    init(homeRootView: AnyView) {
        self.homeRootView = homeRootView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }

    private func setupTabs() {
        // 首页 Tab - 已经由外部注入了 HomeViewModel
        let homeHostingController = UIHostingController(rootView: homeRootView)
        homeHostingController.tabBarItem = UITabBarItem(
            title: "首页",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        // 我的 Tab
        let profileView = ProfileView()
        let profileHostingController = UIHostingController(rootView: profileView)
        profileHostingController.tabBarItem = UITabBarItem(
            title: "我的",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        // 每个 Tab 都包装在 UINavigationController 中，支持独立导航
        let homeNavController = UINavigationController(rootViewController: homeHostingController)
        // 首页隐藏导航栏，因为 HomeView 自己绘制了标题
        homeNavController.navigationBar.isHidden = true

        let profileNavController = UINavigationController(rootViewController: profileHostingController)

        viewControllers = [homeNavController, profileNavController]
    }

    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.theme.background)

        let normalColor = UIColor(Color.theme.secondaryText)
        let selectedColor = UIColor(Color.theme.accent)

        appearance.stackedLayoutAppearance.normal.iconColor = normalColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: normalColor
        ]
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: selectedColor
        ]

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
