//
//  CryproService.swift
//  TestApplication
//
//  Created by Владимир on 27.05.2025.
//

import Foundation

final class CryptoService {
    private let baseURL = Constants.Network.cryptoBaseURL
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    
    private func request<T: Decodable>(_ endpoint: CryptoEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + endpoint.path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse(statusCode: 0)))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
    
    
    func fetchAssetMetrics(for assetKey: String, completion: @escaping (Result<CryptoResponse, NetworkError>) -> Void) {
        let endpoint = CryptoEndpoint.assetMetrics(assetKey: assetKey)
        request(endpoint, completion: completion)
    }
}
