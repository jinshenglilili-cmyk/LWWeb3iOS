//
//  ProfileView.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("我的")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.accent)

                Text("开发中...")
                    .font(.title2)
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
        .navigationTitle("我的")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
