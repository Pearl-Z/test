//
//  HomeStatsView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/8.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPotfoli: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach (vm.stats) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width/3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPotfoli ? .trailing : .leading)
        .animation(.spring(), value: showPotfoli)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPotfoli: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
