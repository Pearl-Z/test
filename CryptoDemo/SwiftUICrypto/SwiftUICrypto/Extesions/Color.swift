//
//  Color.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/3.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launch = ColorLaunch()
    
}


struct ColorTheme {
    
    let accent = Color("AccentColor")
    let backeground = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}


struct ColorLaunch {
    
    let backgroud = Color("LaunchBackgroundColor")
    let accent = Color("LaunchAccentColor")
    
}
