//
//  ExchangeViewModel.swift
//  ExchangeRate
//
//  Created by Leo Gabuev on 14.05.2026.
//

import Foundation

final class ExchangeViewModel {
    weak var delegate: ExchangeViewModelDelegate?
    private let service = NetworkService()
    private var allRates: [String: Double] = [:]
    private var currencyCodes: [String] = []
    private var baseAmountInSystemCurrency: Double = 1.0
    
    func loadData (){
        service.fetch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.allRates = data.conversionRates
                    self?.currencyCodes = data.conversionRates.keys.sorted()
                    self?.delegate?.didFetchCurrencies(data.conversionRates)
                case .failure(let error):
                    self?.delegate?.didFailWithError(error.localizedDescription)
                }
            }
        }
    }
    
    func numberOfRows() -> Int {
        return currencyCodes.count
    }

    func getCurrencyCode(at index: Int) -> String {
        return currencyCodes[index]
    }

    func getAmount(at index: Int) -> Double {
        let code = currencyCodes[index]
        let rate = allRates[code] ?? 1.0
        
        return baseAmountInSystemCurrency * rate
    }
    
    func updateAmount(newAmount: Double, for currencyCode: String) {
        let rate = allRates[currencyCode] ?? 1.0
        baseAmountInSystemCurrency = newAmount / rate
        delegate?.didFetchCurrencies(allRates)
    }
}
