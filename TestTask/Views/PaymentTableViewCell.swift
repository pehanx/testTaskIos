//
//  PaymentTableViewCell.swift
//  TestTask
//
//  Created by Nikita Spekhin on 20.10.2021.
//

import Foundation
import UIKit

class PaymentTableViewCell:UITableViewCell {
    
    // MARK: - Properties
    static let cellId = String(describing: PaymentTableViewCell.self)
    
    // MARK: - Views
    private let amountLabel = UILabel()
    private let descLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private let currencyLabel = UILabel()
    private let createdLabel = UILabel()
    
    private lazy var amountSV:UIStackView = createStackView(title: "Сумма", label: amountLabel)
    private lazy var currencySV:UIStackView = createStackView(title: "Валюта", label: currencyLabel)
    private lazy var createdSV:UIStackView = createStackView(title: "Дата", label: createdLabel)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Helpers
    private func setupUI(){
        let stackView = UIStackView(arrangedSubviews: [
            amountSV, currencySV, createdSV, descLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints{$0.edges.equalToSuperview().inset(12)}
    }
    
    func bindData(payment:Payment?) {
        guard let payment = payment else {
            return
        }

        amountLabel.text = payment.amount.stringValue
        descLabel.text = payment.desc
        
        if let currency = payment.currency {
            currencyLabel.text = currency
        } else {
            currencySV.isHidden = true
        }
        createdLabel.text = payment.created.convertedDate
        
    }
    
    private func createStackView(title:String, label:UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, label])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }
}
