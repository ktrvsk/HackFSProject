//
//  ViewController.swift
//  HackathonProject
//
//  Created by Ksusha on 09.07.2022.
//

import UIKit
import web3swift

protocol CreateWalletControllerProtocol {
    func openNext()
}

class CreateWalletController: UIViewController, CreateWalletControllerProtocol {

    //MARK: - Properties
    @IBOutlet weak var walletNameTextField: UITextField!
    @IBOutlet weak var createWalletButton: UIButton!
    
    var presenter: CreateWalletPresenterProtocol = CreateWalletPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        setupButton()
    }
    
    func openNext() {
        let tabBarControllers: TabBarControllerProtocol = TabBarController()
        navigationController?.setViewControllers([tabBarControllers], animated: true)
//        let controller = LoadBalanceViewController()
//        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func setupButton() {
        createWalletButton.layer.borderWidth = 0.5
        createWalletButton.layer.borderColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        createWalletButton.layer.cornerRadius = 5
    }
    
    @IBAction private func createWalletTapped(_ sender: Any) {
        guard let wallet = walletNameTextField.text else { return }
        if !wallet.isEmpty {
            do {
                
                let walletNew = try presenter.createWallet(name: wallet)
            }
            catch {
                print(error)
            }
        }
    }
}

