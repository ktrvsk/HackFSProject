//
//  TokenBalanceCell.swift
//  HackathonProject
//
//  Created by Ksusha on 18.07.2022.
//

import UIKit
import BigInt

protocol TokenBalanceCellDelegate {
    func sendTokenButtonTapped()
}

final class TokenBalanceCell: UITableViewCell, Reusable {
    
//MARK: - Properties
    
    private lazy var nameTokenLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var balanceTokenLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var sendTokenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = .darkGray
        button.setTitle("SEND", for: .normal)
        button.addTarget(self, action: #selector(addButtonAction), for: UIControl.Event.touchUpInside)
        return button
    }()

    private var tokenBalanceCellModel: TokenBalanceCellModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = false
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCell(with model: TokenBalanceCellModel) -> Self {
        tokenBalanceCellModel = model
        nameTokenLabel.text = model.nameToken
        balanceTokenLabel.text = model.balance
        return self
    }
    
// MARK: - Setup UI Elements
    private func setupCell() {
        setupSendButton()
        setupBalanceTokenLabel()
        setupNameTokenLabel()
    }

    private func setupNameTokenLabel() {
        addSubview(nameTokenLabel)
        NSLayoutConstraint.activate([
            nameTokenLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameTokenLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            nameTokenLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            nameTokenLabel.bottomAnchor.constraint(equalTo: balanceTokenLabel.topAnchor, constant: -5)
        ])
    }
    
    private func setupBalanceTokenLabel() {
        addSubview(balanceTokenLabel)
        NSLayoutConstraint.activate([
            balanceTokenLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            balanceTokenLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            balanceTokenLabel.bottomAnchor.constraint(equalTo: sendTokenButton.topAnchor, constant: -5),
            balanceTokenLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupSendButton() {
        addSubview(sendTokenButton)
        NSLayoutConstraint.activate([
            sendTokenButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            sendTokenButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            sendTokenButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            sendTokenButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc
    private func addButtonAction(button: UIButton) {
        tokenBalanceCellModel?.actionHandler()
    }
}
