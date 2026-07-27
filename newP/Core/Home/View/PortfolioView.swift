//
//  portfolioView.swift
//  newP
//
//  Created by Liwei on 2026/1/5.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var selectcoin : CoinModel?
    @State private var quentity : String = ""
    @State private var showCheckMark : Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoView
                    if selectcoin != nil {
                        portfolioInputValue
                    }
                }
            }
            .navigationTitle("edit")
            .toolbar(content: {
                ToolbarItem (placement: .topBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // 核心：加 wrappedValue
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    })
                }
                ToolbarItem (placement: .topBarTrailing){
                   trailingNavButton
                }
            })
        }
    }
}

#Preview {
//    PortfolioView()
//        .environmentObject(DeveloperPreview.instance.homeVM)

}

extension PortfolioView {
    var coinLogoView: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoImageView(coin: coin)
                        .frame(width: 75)
                        .onTapGesture {
                            withAnimation {
                                selectcoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectcoin?.id == coin.id ?  Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    
    
    func getCurrentValue(quentity : String) -> Double {
        if let value = Double(quentity) {
            return value * (selectcoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    var portfolioInputValue : some View {
        VStack(spacing: 20){
            HStack{
                Text("price \(selectcoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text( selectcoin?.currentPrice.asCurrentcyWith2Decimals() ?? "0")
            }
            Divider()
            HStack{
                Text("amout \(selectcoin?.symbol.uppercased() ?? "")")
                Spacer()
                TextField("ex:1.4", text: $quentity)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("value")
                Spacer()
                Text("amout \(getCurrentValue(quentity: quentity).asCurrentcyWith2Decimals())")
            }
        }
        .animation(nil, value: false)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavButton : some View {
        HStack{
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            
            Button {
                saveButtonClick()
            } label: {
                Text("save".uppercased())
            }
            .opacity(selectcoin != nil && selectcoin?.currentHoldings != Double(quentity) ? 1.0 : 0.0)
                
        }
        .font(.headline)
    }
    
    private func saveButtonClick(){
        guard let coin = selectcoin ,let amount = Double(quentity) else {return}
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckMark = true
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            showCheckMark = false
        })
    }
    
    private func updateSelectCoin(){
        selectcoin = nil
    }
    
    private func removeSelectCoin(){
        selectcoin = nil
        vm.searchText = ""
    }
}

