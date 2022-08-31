//
//  CircleButton.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/3.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(.theme.accent)
            .frame(width: 50, height: 50, alignment: .center)
            .background {
                Circle()
                    .foregroundColor(.theme.backeground)
            }
            .shadow(color: .theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            CircleButtonView(iconName: "info")
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "plus")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
        
    }
}
