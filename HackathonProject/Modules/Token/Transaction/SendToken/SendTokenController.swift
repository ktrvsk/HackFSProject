//
//  SendTokenController.swift
//  HackathonProject
//
//  Created by Ksusha on 20.07.2022.
//

import Foundation
import UIKit

protocol SendTokenControllerProtocol {
    func getTokenContractAddress(with address: String)
}

class SendTokenController: UIViewController, SendTokenControllerProtocol {

// MARK: - @IBOutlet

    @IBOutlet weak var toAddressTextFiled: UITextField!
    @IBOutlet weak var quantityЕthTextFiled: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
// MARK: - Properties
    
    var presenter: SendTokenPresenterProtocol = SendTokenPresenter()
    var contractAddress: String = ""
    
//MARK: - @IBAction
    
    @IBAction func sendEthPressed(_ sender: UIButton) {
        guard let address = toAddressTextFiled.text else { return }
        guard let quantity = quantityЕthTextFiled.text else { return }
//        presenter.sendEth(toAddress: address, quantityЕth: quantityЕth)
        presenter.sendERC20Token(toAddress: address, quantityЕRC20Token: quantity)
    }

//MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
    }

//MARK: - Public method
    
    func getTokenContractAddress(with address: String) {
        contractAddress = address
        presenter.getTokenContractAddress(with: contractAddress)
    }
}
