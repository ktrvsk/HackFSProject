//
//  StartViewController.swift
//  HackathonProject
//
//  Created by Ksusha on 10.07.2022.
//

import UIKit

class StartViewController: UIViewController {

// MARK: - @IBOutlet
    
    @IBOutlet weak var creatNewWalletButton: UIButton!
    @IBOutlet weak var loginInWallet: UIButton!
    @IBOutlet weak var cryptoWalletLogo: UILabel!
    
// MARK: - Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoLabel()
    }
    
    
    @IBAction func creatNewWalletButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createWalletController = storyboard.instantiateViewController(withIdentifier: "createWallet")
        navigationController?.pushViewController(createWalletController , animated: true)
    }
    
    @IBAction func loginInWalletButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let restoreWalletController = storyboard.instantiateViewController(withIdentifier: "tabBar")
        navigationController?.pushViewController(restoreWalletController , animated: true)
    }
    
    private func setupLogoLabel() {
        cryptoWalletLogo.text = ""
        var charIndex = 0.0
        let titleText = "CryptoWallet"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { timer in
                self.cryptoWalletLogo.text?.append(letter)
            }
            charIndex += 1
        }
    }
}
