//
//  RestoreWalletController.swift
//  HackathonProject
//
//  Created by Ksusha on 10.07.2022.
//

import UIKit

protocol RestoreWalletControllerProtocol {
    func openNext()
    func showLoader()
}

class RestoreWalletController: UIViewController, RestoreWalletControllerProtocol {
    
// MARK: - @IBOutlet
    @IBOutlet weak var mnemonicsTextField: UITextField!
    @IBOutlet weak var restoreWalletButton: UIButton!
    @IBOutlet private var loaderView: UIView!
    @IBOutlet private var activityView: UIActivityIndicatorView!
    
// MARK: - Properties
    var presenter: RestoreWalletPresenterProtocol = RestoreWalletPresenter()
    
    private var mnemonicsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        setupButton()
    }
    
// MARK: Public methods
    func openNext() {
        loaderView.isHidden = true
        let tabBarControllers: TabBarControllerProtocol = TabBarController()
        navigationController?.setViewControllers([tabBarControllers], animated: true)
    }
    
    func showLoader() {
        loaderView.isHidden = false
        activityView.startAnimating()
    }
    
// MARK: Private methods
    @IBAction private func restoreWalletPressed(_ sender: UIButton) {
        showLoader()
        mnemonicsArray = mnemonicsTextField.text?.components(separatedBy: " ") ?? []
        if !mnemonicsArray.isEmpty {
            DispatchQueue.global().async {
                do {
                    
                    let restoreWallet = try self.presenter.restoreWalletByMnemonic(by: self.mnemonicsArray)
                }
                catch {
                    print(error)
                    DispatchQueue.main.async {
                        self.loaderView.isHidden = true
                    }
                }
            }
        }
    }
    
    private func setupButton() {
        restoreWalletButton.layer.borderWidth = 0.5
        restoreWalletButton.layer.borderColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        restoreWalletButton.layer.cornerRadius = 5
    }
}
