//
//  NFTDetailController.swift
//  HackathonProject
//
//  Created by Ksusha on 21.07.2022.
//

import Foundation
import UIKit

protocol NFTDetailControllerProtocol {
    func getNftData(address: String, name: String, tokenId: String)
}

class NFTDetailController: UIViewController, NFTDetailControllerProtocol {

// MARK: - @IBOutlet

    @IBOutlet weak var tokenName: UILabel!
    @IBOutlet weak var tokenAddress: UILabel!
    @IBOutlet weak var toAddress: UITextField!
    
    private var nameNft: String = ""
    private var addressNft: String = ""
    var presenter: NFTDetailPresenterProtocol = NFTDetailPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    
    @IBAction func sendNftButtonTapped(_ sender: UIButton) {
        guard let address = toAddress.text else { return }
        presenter.sendERC721Token(toAddres: address)
        
    }
    
    func getNftData(address: String, name: String, tokenId: String) {
        nameNft = name
        addressNft = address
        presenter.getNftContractAddress(with: address)
    }
    
    private func setupLabels() {
        tokenName.text = nameNft
        tokenAddress.text = addressNft
    }
    
    private func setupAddressLaleb() {
        tokenAddress.numberOfLines = 0
    }
}

