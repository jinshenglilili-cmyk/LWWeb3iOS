//
//  MainTabCoordinator.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import SwiftUI
import UIKit

struct MainTabControllerRepresentable: UIViewControllerRepresentable {

    @EnvironmentObject var homeViewModel: HomeViewModel

    func makeUIViewController(context: Context) -> MainTabBarController {
        // 在这一层已经可以获取到 homeViewModel，直接创建并注入环境对象
        let homeView = HomeView()
            .environmentObject(homeViewModel)

        // 使用 erasure 擦除类型，传给 MainTabBarController
        let tabController = MainTabBarController(homeRootView: AnyView(homeView))
        return tabController
    }

    func updateUIViewController(_ uiViewController: MainTabBarController, context: Context) {
        // 由于环境对象已经通过构造传入，这里不需要更新
    }
}
