//
//  CryptoEndpoint.swift
//  TestApplication
//
//  Created by Владимир on 27.05.2025.
//

import Foundation

enum CryptoEndpoint {
    case assetMetrics(assetKey: String)
    
    var path: String {
        switch self {
        case .assetMetrics(let assetKey):
            return "/api/v1/assets/\(assetKey)/metrics"
        }
    }
}
