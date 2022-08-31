//
//  HapticManager.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/16.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notifacation(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
