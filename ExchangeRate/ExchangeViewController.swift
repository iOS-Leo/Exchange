//
//  ExchangeViewController.swift
//  ExchangeRate
//
//  Created by Leo Gabuev on 13.05.2026.
//

import UIKit

final class ExchangeViewController : UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Exchange Currency"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currencyAmountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите сумму"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(currencyAmountTextField)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate ([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            currencyAmountTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            currencyAmountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40) ,
            currencyAmountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            currencyAmountTextField.heightAnchor.constraint(equalToConstant: 45),
                                                           
            resultLabel.topAnchor.constraint(equalTo: currencyAmountTextField.bottomAnchor, constant: 40),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}
