//
//  NetworkError.swift
//  TestApplication
//
//  Created by Владимир on 28.05.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
      case invalidResponse(statusCode: Int)
      case noData
      case decodingError(Error)
      case networkError(Error)
      
      var localizedDescription: String {
          switch self {
          case .invalidURL:
              return "Invalid URL provided"
          case .invalidResponse(let statusCode):
              return "Invalid server response with status code: \(statusCode)"
          case .noData:
              return "No data received from server"
          case .decodingError(let error):
              return "Failed to decode data: \(error.localizedDescription)"
          case .networkError(let error):
              return "Network request failed: \(error.localizedDescription)"
          }
      }
}
