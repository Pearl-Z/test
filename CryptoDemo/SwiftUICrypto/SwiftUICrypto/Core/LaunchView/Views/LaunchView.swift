//
//  LaunchView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/18.
//

import SwiftUI

struct LaunchView: View {
    
    @Binding var showLaunchView: Bool
    
    @State private var showLoadingText: Bool = false
    private let loadingChars: [String] = "Loading your portfolio...".map { String($0) }
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var loops = 0
    @State private var counter = 0
    
    var body: some View {
        ZStack {
            Color.launch.backgroud
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFit()
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingChars.indices, id: \.self) { index in
                            Text(loadingChars[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.launch.accent)
                                .offset(x: 0, y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y:70)
            
        }
        .onAppear{
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                if counter == loadingChars.count - 1 {
                    counter = 0
                    loops += 1
                    if loops == 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
