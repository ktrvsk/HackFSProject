//
//  TokenBalancePresenter.swift
//  HackathonProject
//
//  Created by Ksusha on 18.07.2022.
//

import Foundation

protocol TokenBalancePresenterProtocol {
    var controller: TokenBalanceControllerProtocol? { get set }
    func viewDidLoad()
}

final class TokenBalancePresenter: TokenBalancePresenterProtocol {

// MARK: - Properties
    var controller: TokenBalanceControllerProtocol?
    private var models: [TokenBalanceCellModel] = []

    func viewDidLoad(){
        getBalanceToken()
    }
    
// MARK: - Private method
    private func getBalanceToken() {
        
        guard let address = UserDefaults.standard.string(forKey: "walletAddress") else {
            return
        }
        guard let url = URL(string: "https://api.covalenthq.com/v1/80001/address/\(address)/balances_v2/?&key=ckey_6915c2532adc4f9ebe5c151a3d5")
        else { return }
        Provider.shared.loadData(url: url, method: .GET) { [weak self] (data: TokenDataModel) in
            guard let self = self else {
                return
            }
            self.models = data.data.items.map{ item in
                TokenBalanceCellModel(
                    nameToken: item.contractName,
                    balance: item.balance
                ) { [weak self] in
                    self?.controller?.openSendTransaction(with: item.contractAddress)
                }
            }
            DispatchQueue.main.async {
                self.controller?.reloadTable(models: self.models)
            }
        }
    }
}

