//
//  CurrencyCell.swift
//  ExchangeRate
//
//  Created by Leo Gabuev on 14.05.2026.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    static let reuseIdentifier = "CurrencyCell"
    
    var onAmountChanged: ((Double) -> Void)?
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .decimalPad
        tf.textAlignment = .right
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(codeLabel)
        contentView.addSubview(amountTextField)
        
        NSLayoutConstraint.activate([
            codeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            codeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            amountTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            amountTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountTextField.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        amountTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        let text = amountTextField.text?.replacingOccurrences(of: ",", with: ".") ?? ""
        let amount = Double(text) ?? 0.0
        onAmountChanged?(amount)
    }
    
    func configure(with code: String, amount: Double) {
        codeLabel.text = code
        if !amountTextField.isFirstResponder {
            amountTextField.text = String(format: "%.2f", amount)
        }
    }
    
    func isFirstResponderInTextField() -> Bool {
        return amountTextField.isFirstResponder
    }
}
