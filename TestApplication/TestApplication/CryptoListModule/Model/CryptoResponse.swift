//
//  Model.swift
//  TestApplication
//
//  Created by Владимир on 27.05.2025.
//

import Foundation

struct CryptoResponse: Decodable {
    let data: CryptoResponseData
}

struct CryptoResponseData: Decodable {
    let name: String
    let symbol: String
    let marketData: MarketData
    let marketcap: Marketсap
    let supply: Supply
    
    enum CodingKeys: String, CodingKey {
        case name, symbol, marketcap
        case marketData = "market_data"
        case supply
    }
}


struct MarketData: Decodable {
    let price: Double
    let percentChangeUsdLast24Hours: Double
    enum CodingKeys: String, CodingKey {
        case price = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
    }
}

struct Marketсap: Decodable {
    let currentMarketcapUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case currentMarketcapUsd = "current_marketcap_usd"
        
    }
}

struct Supply: Codable {
    let circulating: Double
}
