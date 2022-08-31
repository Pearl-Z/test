//
//  UIApplication.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/8.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

