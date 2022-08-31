//
//  DetailView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/16.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    
    var body: some View {
        if let coin = coin {
            DetailView(coin: coin)
        }
    }
}


struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    
    private let gridItems: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        
        ScrollView {
            
            ChartView(coin: vm.coin)
            
            VStack(alignment: .leading, spacing: 20) {
                
                overviewTitle
                    
                Divider()
            
                descriptionSection
                
                overviewGrid
                
                
                additionalTitle
                    
                Divider()
                
                additionalGrid
                
                websiteSection
                
            }
            .padding()
            
   
        }
        .background(Color.theme.backeground)
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem {
                HStack {
                    Text(vm.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundColor(.theme.secondaryText)
                    CoinImageView(coin: vm.coin)
                        .frame(width: 25, height: 25)
                }
            }
        }
    }
}




struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}


extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: gridItems, alignment: .leading, spacing: 30, pinnedViews: []) {
            ForEach (vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: gridItems, alignment: .leading, spacing: 30, pinnedViews: []) {
            ForEach (vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var descriptionSection: some View {
        
        ZStack {
            if let coinDesc = vm.coinDescription,
               !coinDesc.isEmpty {
                
                VStack(alignment: .leading) {
                    Text(coinDesc)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                        .lineLimit(showFullDescription ? nil : 3)
                    
                    Button {
                        withAnimation {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .bold()
                            .padding(.vertical, 4)
                        
                    }
                    .foregroundColor(.blue)

                }
                
            }
        }
    }
    
    private var websiteSection: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            if let websiteUrl = vm.websiteURL,
               let webUrl = URL(string: websiteUrl) {
                Link("Website", destination: webUrl)
            }
            
            if let additUrl = vm.websiteURL,
               let addUrl = URL(string: additUrl) {
                Link("Reddit", destination: addUrl)
            }
        }
        .font(.headline)
        .foregroundColor(.blue)
    }
    
}

