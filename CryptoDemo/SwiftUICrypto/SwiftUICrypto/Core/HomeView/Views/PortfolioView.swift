//
//  PortfolioView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/9.
//

import SwiftUI
import Combine

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    @State var selectedCoin: CoinModel? = nil
    //    let onePxWidth = 1.0 / UIScreen.main.scale
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchString: $vm.searchString)
                    coinsLogoList
                    if selectedCoin != nil {
                        portfolioEditingSection
                    }
                }
            }
            .background(
                Color.theme.backeground
            )
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            }
            .onChange(of: vm.searchString) { newValue in
                if newValue.isEmpty {
                    removeSelectedCoin()
                }
            }
        }
    }
}


extension PortfolioView {
    
    private var coinsLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach ((vm.searchString.isEmpty && !vm.portfolionCoins.isEmpty) ? vm.portfolionCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            updateSelectCoin(coin: coin)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                            
                        )
                }
            }
        }
        .padding()
    }
    
    private func updateSelectCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = vm.portfolionCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        guard let coin = selectedCoin else {
            return 0.00
        }
        return coin.currentPrice * (Double(quantityText) ?? 0.0)
    }
    
    private var portfolioEditingSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin!.symbol.uppercased())")
                Spacer()
                Text(selectedCoin!.currentPrice.asCurrencyWith6Decimas())
            }
            
            Divider()
            
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField.init("Ex:1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack {
                Text("Current values:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimas())
            }
        }
        .padding()
        
    }
    
    private var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
                .foregroundColor(.theme.accent)
            
            Button{
                saveButtonPressed()
            } label: {
                Text("SAVE")
                    .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
            }
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
        else { return }
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchString = ""
    }
    
}





struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
