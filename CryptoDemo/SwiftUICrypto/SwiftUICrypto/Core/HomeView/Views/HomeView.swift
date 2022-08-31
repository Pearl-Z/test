//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/3.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    @State private var showSettingView: Bool = false
    @State private var showAll: Bool = true
    @State private var showCircleAnimate: Bool = false

    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetail: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.backeground
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            VStack {
                
                homeHader
                
                HomeStatsView(showPotfoli: $showPortfolio)
                
                SearchBarView(searchString: $vm.searchString)
                
                columnTitles
                if showAll {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    
                    ZStack(alignment: .top) {
                        if vm.portfolionCoins.isEmpty && vm.searchString.isEmpty {
                            portfolioEmptyText

                        } else {
                            portfolioCoinsList
                        }
                    }
                    .transition(.move(edge: .trailing))
                
                }
            }
            .sheet(isPresented: $showSettingView) {
                SettingsView()
            }
  
        }
        .background(
            NavigationLink(isActive: $showDetail, destination: {
                DetailLoadingView(coin: $selectedCoin)
            }, label: {
                EmptyView()
            })
        )
        
    }
}

extension HomeView {
    
    private var homeHader: some View {
        HStack {
            
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background {
                    CircleButtonAnimationView(animate: $showCircleAnimate)
                }
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingView.toggle()
                    }
                    
                }
            
            Spacer()
            
            Text(showPortfolio ? "Protholio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none, value: showPortfolio)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                        showAll.toggle()
                    }
                    
                    showCircleAnimate.toggle()
                }
        }
        .padding(.horizontal)
    }
    
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(showHostingsColumn: false, coinModel: coin)
                    .listRowBackground(Color.theme.backeground)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
        
    }
    
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolionCoins) { coin in
                CoinRowView(showHostingsColumn: true, coinModel: coin)
                    .listRowBackground(Color.theme.backeground)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    
    private var portfolioEmptyText: some View {
        VStack {
            Text("You haven't added any coins to your portfolio yet. Click the + button to get started! 🧐")
                .font(.callout)
                .foregroundColor(.theme.accent)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(50)
            Spacer()
            
        }
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetail.toggle()
    }
    
    private var columnTitles: some View {
        HStack {
            
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
                
            
            Button {
                withAnimation(.linear(duration: 2)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
        
        
    }
}
