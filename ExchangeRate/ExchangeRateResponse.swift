//
//  ExchangeRateResponse.swift
//  ExchangeRate
//
//  Created by Leo Gabuev on 13.05.2026.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let result: String
    let baseCode: String
    let conversionRates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case result
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}
