//
//  CoinLogoView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/9.
//

import SwiftUI

struct CoinLogoView: View {
    var coin: CoinModel
    var body: some View {
        VStack {
            
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .lineLimit(1)
                .font(.headline)
                .foregroundColor(.theme.accent)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .lineLimit(2)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .minimumScaleFactor(0.5)
        }
        
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
