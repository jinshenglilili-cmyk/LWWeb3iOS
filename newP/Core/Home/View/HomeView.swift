//
//  HomeView.swift
//  newP
//
//  Created by Liwei on 2025/12/30.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortFolio : Bool = false
    @State private var showPortFolioView : Bool = false

    @EnvironmentObject private var vm : HomeViewModel
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortFolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
                
            VStack {
                headerView
                HomeStateView(showPortFolio: $showPortFolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitle
                
                if !showPortFolio {
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                
                if showPortFolio {
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
        
    }
}

extension HomeView {
    var headerView : some View {
        HStack {
            CircleButtonView(iconName: showPortFolio ? "plus":"info")
                .animation(.none, value: showPortFolio)
                .onTapGesture {
                    if showPortFolio {
                        showPortFolioView.toggle()
                    }
                }
            Spacer()
            Text(showPortFolio ? "livePrice":"portfflio")
                .font(Font.headline)
                .fontWeight(Font.Weight.heavy)
                .foregroundStyle(.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortFolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortFolio.toggle()
                    }
                } 
        }
        
    }
    
    private var allCoinList : some View {
        List {
            ForEach(vm.allCoins) { coin in
//                NavigationLink {
//                    DetailView(coin: coin)
//                } label: {
                    CoinRowView(coin: coin, isShowHoldingColum: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .onTapGesture {
                            print(123)
                        }
//                }
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinList : some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, isShowHoldingColum: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitle : some View {
        HStack {
            Text("coin")
            Spacer()
            if showPortFolio {
                Text("holding")
            }
            Text("price")
                .frame(width: UIScreen.main.bounds.width / 3.5 ,alignment: .trailing)

        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding()
    }
}

#Preview {
    HomeView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}
