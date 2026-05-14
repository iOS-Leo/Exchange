//
//  ExchangeViewController.swift
//  ExchangeRate
//
//  Created by Leo Gabuev on 13.05.2026.
//

import UIKit

final class ExchangeViewController : UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let viewModel = ExchangeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupViewModel()
        viewModel.loadData()
    }
    
    private func setupUI () {
        view.backgroundColor = .systemBackground
        title = "Курс валют"
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.reuseIdentifier)
    }
    private func setupViewModel() {
        viewModel.delegate = self
    }
}

extension ExchangeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifier, for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        
        let code = viewModel.getCurrencyCode(at: indexPath.row)
        let amount = viewModel.getAmount(at: indexPath.row)
        
        cell.configure(with: code, amount: amount)
        cell.onAmountChanged = { [weak self] newAmount in
            self?.viewModel.updateAmount(newAmount: newAmount, for: code)
        }
        return cell
    }
}

extension ExchangeViewController: ExchangeViewModelDelegate {
    
    
    
    func didFetchCurrencies(_ rates: [String : Double]) {
        
        if tableView.numberOfRows(inSection: 0) == 0 {
                tableView.reloadData()
                return
            }
        
        let visibleIndexPaths = tableView.indexPathsForVisibleRows ?? []
        for indexPath in visibleIndexPaths {
            
            if let cell = tableView.cellForRow(at: indexPath) as? CurrencyCell {
                
                if !cell.isFirstResponderInTextField() {
                    let code = viewModel.getCurrencyCode(at: indexPath.row)
                    let amount = viewModel.getAmount(at: indexPath.row)
                    cell.configure(with: code, amount: amount)
                }
            }
        }
    }
    func didFailWithError(_ message: String) {
        print("Ошибка: \(message)")
    }
}
