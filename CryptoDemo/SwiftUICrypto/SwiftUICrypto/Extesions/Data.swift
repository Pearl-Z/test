//
//  Data.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/17.
//

import Foundation

extension Date {
    
    init(coinString: String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let data = formatter.date(from: coinString) ?? Date()
        self.init(timeInterval: 0, since: data)
    }
    
    
    private var shortDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortDateFormatter.string(from: self)
    }
}
