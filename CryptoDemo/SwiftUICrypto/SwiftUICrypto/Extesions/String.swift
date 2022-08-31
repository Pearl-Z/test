//
//  String.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/17.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
