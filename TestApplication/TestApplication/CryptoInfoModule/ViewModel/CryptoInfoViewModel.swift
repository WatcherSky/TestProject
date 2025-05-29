//
//  CryptoInfoViewModel.swift
//  TestApplication
//
//  Created by Владимир on 28.05.2025.
//

import Foundation
import UIKit

final class CryptoInfoViewModel {
    var cryptoData: CryptoData
    var output: CryptoInfoFlow?
    
    init(cryptoData: CryptoData) {
        self.cryptoData = cryptoData
    }
    
    func formatNumberSmart(_ value: Double) -> String {
        if value > 1{
            return String(format: "%.2f", value)
        } else {
            return String(format: "%.3f", value)
        }
    }
    
    func logout() {
        output?.logout()
    }
}
