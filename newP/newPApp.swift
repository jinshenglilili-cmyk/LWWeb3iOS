//
//  newPApp.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import SwiftUI

@main
struct newPApp: App {
    @StateObject private var vm = HomeViewModel()
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    var body: some Scene {
        WindowGroup {
            MainTabControllerRepresentable()
                .environmentObject(vm)
        }
    }
}
