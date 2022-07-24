//
//  NFTBalancePresenter.swift
//  HackathonProject
//
//  Created by Ksusha on 19.07.2022.
//

import Foundation

protocol NFTBalancePresenterProtocol {
    var controller: NFTBalanceControllerProtocol? { get set }
    func viewDidLoad()
}

final class NFTBalancePresenter: NFTBalancePresenterProtocol {
    
    var controller: NFTBalanceControllerProtocol?
    
    private var models: [NFTCellModel] = []
    private var nftDataModels: [NDataModel] = []
    
    func viewDidLoad() {
        loadData()
    }
    
    func loadData() {
        
        guard let address = UserDefaults.standard.string(forKey: "walletAddress") else {
            return
        }
        
        guard let url = URL(string: "https://api.covalenthq.com/v1/80001/address/\(address)/balances_v2/?quote-currency=USD&format=JSON&nft=true&no-nft-fetch=true&key=ckey_6915c2532adc4f9ebe5c151a3d5") else { return }
        
        Provider.shared.loadData(url: url, method: .GET) { [weak self] (data: NftDataModel) in
            guard let self = self else {
                return
            }
            self.nftDataModels = data.data.items
                .compactMap { item in
                    guard let tokenId = item.nftData?.first?.tokenID else {
                        return nil
                    }
                    let model =  NDataModel(
                        contractName: item.contractName,
                        contractAddress: item.contractAddress,
                        tokenId: tokenId
                    )
                    self.loadMetadata(with: model)
                    return model
                }
        }
    }
    
    func loadMetadata(with nft: NDataModel) {
        guard let url = URL(string: "https://api.covalenthq.com/v1/80001/tokens/\(nft.contractAddress)/nft_metadata/\(nft.tokenId)/?&key=ckey_6915c2532adc4f9ebe5c151a3d5") else { return }
        Provider.shared.loadData(url: url, method: .GET) { [weak self] (data: Welcome) in
            guard let self = self else {
                return
            }
            self.models = data.data.items
                .flatMap { $0.nftData }
                .map { nftData in
                    NFTCellModel(image: nftData.externalData.image512)
                    { [weak self] in
                        self?.controller?.openNftDetailController(address: nft.contractAddress, name: nft.contractName, tokenId: nft.tokenId)
                    }
                }
            DispatchQueue.main.async {
                self.controller?.setModels(model: self.models)
            }
        }
    }
}
