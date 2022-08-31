//
//  CircleButtonAnimationView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/3.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool
    
    var body: some View {
    
        Circle()
            .stroke(lineWidth: 5.0)
            .opacity(animate ? 0.0 : 1.0)
            .scaleEffect(animate ? 1.0 : 0.0)
            .animation(animate ? .easeInOut(duration: 1.0) : .none, value: animate)
    }
}


struct CircleButtonAnimationView_Previews: PreviewProvider {
    
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(true))
            .frame(width: 50, height: 50)
            .foregroundColor(.theme.red)
    }
    
}
