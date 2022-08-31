//
//  SearchBarView.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/8.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchString: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchString.isEmpty ? .theme.secondaryText : .theme.accent)
            TextField("Search by name or symbol...", text: $searchString)
                .foregroundColor(.theme.accent)
                .disableAutocorrection(true)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10, y: 0)
                        .opacity(searchString.isEmpty ? 0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchString = ""
                        }
                        
                }
       
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.backeground)
                .shadow(color: .theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
                
                
        )
        .padding()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            SearchBarView(searchString: .constant(""))
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
            SearchBarView(searchString: .constant(""))
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
 
    }
}
