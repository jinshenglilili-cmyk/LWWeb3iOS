//
//  SearchBarView.swift
//  newP
//
//  Created by Liwei on 2026/1/4.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText : String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.theme.secondaryText:Color.theme.accent)
            TextField("输入搜索内容", text: $searchText)
                .foregroundStyle(.accent)
                .disableAutocorrection(true)
                .overlay(alignment: .trailing, content: {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 20)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0 )
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                })
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

#Preview {
    Group{
        SearchBarView(searchText: .constant(""))
    }
}
