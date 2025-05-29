//
//  CryptoListViewModel.swift
//  TestApplication
//
//  Created by Владимир on 27.05.2025.
//

import Foundation
import UIKit

final class CryptoListViewModel {
    var cryptoModel: Observable<CryptoData?> = Observable(nil)
    var onUpdate: (() -> Void)?
    var output: CryptoListFlow?
    let cryptoList = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    
    private let cryptoService: CryptoService
    var cryptoData: [CryptoData] = []

    private let semaphore = DispatchSemaphore(value: 3)
    
    init(cryptoService: CryptoService) {
        self.cryptoService = cryptoService
    }
    
    func fetchCryptoData(for assetKey: String, group: DispatchGroup, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        group.enter()
        
        cryptoService.fetchAssetMetrics(for: assetKey) { [weak self] result in
            defer {
                group.leave()
                self?.semaphore.signal()
            }
            self?.semaphore.wait()

            switch result {
            case .success(let data):
                let cr = CryptoData(
                    name: data.data.name,
                    symbol: data.data.symbol,
                    price: data.data.marketData.price,
                    priceChange: data.data.marketData.percentChangeUsdLast24Hours,
                    marketCap: data.data.marketcap.currentMarketcapUsd,
                    circulatingSupply: data.data.supply.circulating
                )
                self?.cryptoModel.value = cr
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sortCrypto(by ascending: Bool) {
        cryptoData.sort { ascending ? $0.price < $1.price :  $0.price > $1.price }
        onUpdate?()
    }
    
    func formatNumberSmart(_ value: Double) -> String {
        if value > 1{
            return String(format: "%.2f", value)
        } else {
            return String(format: "%.3f", value)
        }
    }
    
    func selectCrypto(crypto: CryptoData) {
        output?.selectCrypto(crypto: crypto)
    }
    
    func logout() {
        output?.logout()
    }
}
