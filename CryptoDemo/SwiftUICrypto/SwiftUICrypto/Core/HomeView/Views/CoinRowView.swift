//
//  CoinRowView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/4.
//

import SwiftUI

struct CoinRowView: View {
    
    let showHostingsColumn: Bool
    let coinModel: CoinModel
    
    var body: some View {
        
        HStack {
            
            HStack {
                Text("\(coinModel.rank)")
                    .foregroundColor(.theme.secondaryText)
                    .font(.caption)
                    .frame(minWidth: 30)
                CoinImageView(coin: coinModel)
                    .frame(width: 30, height: 30)
        
                Text(coinModel.symbol.uppercased())
                    .font(.headline)
                    .foregroundColor(.theme.accent)
                    .padding(.leading, 6)
            }
            
            Spacer()
             
            if(showHostingsColumn){

                VStack(alignment: .trailing) {
                    Text(coinModel.currentHoldingsValue.asCurrencyWith2Decimas())
                        .bold()
                    Text(coinModel.currentHoldings?.asNumberString() ?? "")
                }
                .foregroundColor(.theme.accent)
            }
            
            
            VStack(alignment: .trailing) {
                
                Text(coinModel.currentPrice.asCurrencyWith6Decimas())
                    .bold()
                    .foregroundColor(.theme.accent)
                Text(coinModel.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundColor(coinModel.priceChangePercentage24H ?? 0 > 0 ? .theme.green : .theme.red)
                    .foregroundColor(.theme.accent)
                
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .offset(x: -10, y: 0)
            
        }
        .background(Color.theme.backeground)
        
    }
}


struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(showHostingsColumn: true, coinModel: dev.coin)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(showHostingsColumn: true, coinModel: dev.coin)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
        
    }
}
