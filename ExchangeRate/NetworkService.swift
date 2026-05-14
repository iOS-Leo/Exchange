//
//  NetworkService.swift
//  ExchangeRate
//
//  Created by Leo Gabuev on 13.05.2026.
//


import Foundation


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
final class NetworkService {
    private let apiKey = "3656125c817c051040e56027"
    
    func fetch(handler: @escaping (Result<ExchangeRateResponse, Error>) -> Void) {
        
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/USD") else {
            return handler(.failure(NetworkError.invalidURL))
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                handler(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.invalidURL))
                return
            }
            guard let data else {
                handler(.failure(NetworkError.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let exchangeData = try decoder.decode(ExchangeRateResponse.self, from: data)
                DispatchQueue.main.async {
                    handler(.success(exchangeData))
                }
            }
            catch {
                handler(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
}
