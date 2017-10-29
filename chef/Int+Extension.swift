//
//  Int+Extension.swift
//  chef
//
//  Created by Diwakar Kamboj on 28/10/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import Foundation

extension Int {
    func toRupeeString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.locale = Constants.Locales.englishIndia
        return formatter.string(from: NSNumber(integerLiteral: self))!.replacingOccurrences(of: Constants.Strings.nonBreakingSpace, with: "")
    }
}
