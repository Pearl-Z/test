//
//  SettingsView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/18.
//

import SwiftUI

struct SettingsView: View {
    
    let defuletURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://github.com/Pearl-Z")!
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.theme.backeground
                    .ignoresSafeArea()
                
                List {
                    swiftfulThinkingSection
//                        .listRowBackground(Color.black.opacity(0.3))
                    coinGeckoSection
//                        .listRowBackground(Color.black.opacity(0.3))
                    developerSection
//                        .listRowBackground(Color.black.opacity(0.3))
                    applicationSection
//                        .listRowBackground(Color.black.opacity(0.3))
                        
                }
                
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            
                
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on YouTube 🥳", destination: youtubeURL)
            Link("Support his coffee addiction ☕️", destination: coffeeURL)
            
        } header: {
            Text("Swiftful Thinking")
        }
        
    }
    
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(20)
                Text("The cryptocurrency data that is used in this app comes frome a free API frome CoinGecko! Price may be slightly dalayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko 🦎", destination: coinGeckoURL)
            
        } header: {
            Text("CoinGecko")
        }
        
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("developerAvatar")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
                Text("This app was developed by Pearl-Z. It used SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Website 🦉", destination: personalURL)
            
        } header: {
            Text("Developer")
        }
        
    }
    
    private var applicationSection: some View {
        Section {
            Link("Terms of Service", destination: defuletURL)
            Link("Privancy Policy", destination: defuletURL)
            Link("Company Website", destination: defuletURL)
            Link("Learn More", destination: defuletURL)
        } header: {
            Text("Application")
        }

    }
    
    
}
