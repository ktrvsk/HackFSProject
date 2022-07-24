//
//  RestoreWalletByKeyController.swift
//  HackathonProject
//
//  Created by Ksusha on 22.07.2022.
//

import Foundation
import UIKit

protocol RestoreWalletByKeyControllerProtocol {
    func openNext()
    func showLoader()
}

class RestoreWalletByKeyController: UIViewController, RestoreWalletByKeyControllerProtocol {
    
// MARK: - @IBOutlet
    
    @IBOutlet weak var privateKeyTextFiled: UITextField!
    @IBOutlet weak var restoreWallerByKeyButton: UIButton!
    @IBOutlet private var loaderView: UIView!
    @IBOutlet private var activityView: UIActivityIndicatorView!
    
    
// MARK: - Properties
    var presenter: RestoreWalletByKeyPresenterProtocol = RestoreWalletByKeyPresenter()
    var privateKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction private func restoreWalletPressed(_ sender: UIButton) {
//        showLoader()
        privateKey = privateKeyTextFiled.text ?? ""
        if !privateKey.isEmpty {
            DispatchQueue.global().async {
                do {
                    try self.presenter.restoreWalletByPrivateKey(by: self.privateKey)
                }
                catch {
                    print(error)
                    DispatchQueue.main.async {
//                        self.loaderView.isHidden = true
                    }
                }
            }
        }
    }
    
// MARK: Private methods
    
    private func setupButton() {
        restoreWallerByKeyButton.layer.borderWidth = 0.5
        restoreWallerByKeyButton.layer.borderColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        restoreWallerByKeyButton.layer.cornerRadius = 5
    }
    
}
