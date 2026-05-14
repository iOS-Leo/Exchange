//
//  ExchangeViewModelDelegate.swift
//  ExchangeRate
//
//  Created by Leo Gabuev on 14.05.2026.
//

import Foundation

protocol ExchangeViewModelDelegate: AnyObject {
    func didFetchCurrencies(_ rates: [String: Double])
    func didFailWithError(_ message: String)
}
