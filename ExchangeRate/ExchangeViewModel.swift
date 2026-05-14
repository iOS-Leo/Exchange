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
}
