//
//  ProfileController.swift
//  HackathonProject
//
//  Created by Ksusha on 21.07.2022.
//

import Foundation
import UIKit

class ProfileController: UIViewController {
    
// MARK: - Properties
//image
    private lazy var publicAddressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "newspaper")
        imageView.tintColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        return imageView
    }()
    
    private lazy var privateKeyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "key")
        imageView.tintColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        return imageView
    }()
    
    private lazy var mnemonicImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "doc.text")
        imageView.tintColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        return imageView
    }()

//label
    private lazy var publicAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ADDRESS WALLET:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        return label
    }()
    
    private lazy var privateKeyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PRIVATE KEY:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        return label
    }()
    
    private lazy var mnemonicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MNEMONIC PHRASE:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        return label
    }()

//element
    
    private lazy var publicAddress: UILabel = {
        let address = UILabel()
        address.translatesAutoresizingMaskIntoConstraints = false
        address.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        address.textColor = .black
        address.numberOfLines = 0
        return address
    }()
    
    private lazy var privateKey: UILabel = {
        let key = UILabel()
        key.translatesAutoresizingMaskIntoConstraints = false
        key.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        key.textColor = .black
        key.numberOfLines = 0
        return key
    }()
    
    private lazy var mnemonic: UILabel = {
        let mnemonic = UILabel()
        mnemonic.translatesAutoresizingMaskIntoConstraints = false
        mnemonic.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        mnemonic.textColor = .black
        mnemonic.numberOfLines = 0
        return mnemonic
    }()
    
//button
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.6066564322, green: 0.1104470566, blue: 0.1192050949, alpha: 1)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        button.setTitle("LOGOUT", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupElements()
    }
    
    @objc
    func logoutButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "start")
        navigationController?.pushViewController(vc, animated: true)
    }
    
// MARK: - Setup UI Elements
    
    func setupElements() {
        setupNavigationBar()
        setupPublicAddressImage()
        setupPublicAddressLabel()
        setupPublicAddress()
        setupPrivetKeyImage()
        setupPrivateKeyLabel()
        setupPrivateKey()
        setupMnemonicImage()
        setupMnemonicLabel()
        setupMnemonic()
        setupButton()
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "ACCOUNT"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .gray
        navigationItem.titleView = titleLabel
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupPublicAddressImage() {
        view.addSubview(publicAddressImage)
        NSLayoutConstraint.activate([
            publicAddressImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            publicAddressImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            publicAddressImage.heightAnchor.constraint(equalToConstant: 50),
            publicAddressImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupPrivetKeyImage() {
        view.addSubview(privateKeyImage)
        NSLayoutConstraint.activate([
            privateKeyImage.topAnchor.constraint(equalTo: publicAddressImage.bottomAnchor, constant: 70),
            privateKeyImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            privateKeyImage.heightAnchor.constraint(equalToConstant: 50),
            privateKeyImage.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setupMnemonicImage() {
        view.addSubview(mnemonicImage)
        NSLayoutConstraint.activate([
            mnemonicImage.topAnchor.constraint(equalTo: privateKeyImage.bottomAnchor, constant: 70),
            mnemonicImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            mnemonicImage.heightAnchor.constraint(equalToConstant: 50),
            mnemonicImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupPublicAddressLabel() {
        view.addSubview(publicAddressLabel)
        NSLayoutConstraint.activate([
            publicAddressLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            publicAddressLabel.leftAnchor.constraint(equalTo: publicAddressImage.leftAnchor, constant: 60)
        ])
    }
    
    private func setupPrivateKeyLabel() {
        view.addSubview(privateKeyLabel)
        NSLayoutConstraint.activate([
            privateKeyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            privateKeyLabel.leftAnchor.constraint(equalTo: privateKeyImage.leftAnchor, constant: 60)
        ])
    }
    
    private func setupMnemonicLabel() {
        view.addSubview(mnemonicLabel)
        NSLayoutConstraint.activate([
            mnemonicLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 380),
            mnemonicLabel.leftAnchor.constraint(equalTo: privateKeyImage.leftAnchor, constant: 60)
        ])
    }
    
    func setupPublicAddress() {
        view.addSubview(publicAddress)
        guard let address = UserDefaults.standard.string(forKey: "walletAddress") else { return }
        publicAddress.text = address
        NSLayoutConstraint.activate([
            publicAddress.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            publicAddress.leftAnchor.constraint(equalTo: publicAddressImage.leftAnchor, constant: 60),
            publicAddress.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            publicAddress.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupPrivateKey() {
        view.addSubview(privateKey)
        guard let key = UserDefaults.standard.string(forKey: "privateKey") else { return }
        privateKey.text = key
        NSLayoutConstraint.activate([
            privateKey.topAnchor.constraint(equalTo: view.topAnchor, constant: 290),
            privateKey.leftAnchor.constraint(equalTo: privateKeyImage.leftAnchor, constant: 60),
            privateKey.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            privateKey.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupMnemonic() {
        view.addSubview(mnemonic)
        mnemonic.text = ""
        guard let mnemonicPhrase = UserDefaults.standard.object(forKey: "mnemonicPhrase") as? [String]
        else { return }

        for mnemonic in mnemonicPhrase {
            self.mnemonic.text?.append(mnemonic)
            self.mnemonic.text?.append(contentsOf: " ")
        }
        
        NSLayoutConstraint.activate([
            mnemonic.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            mnemonic.leftAnchor.constraint(equalTo: mnemonicImage.leftAnchor, constant: 60),
            mnemonic.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            mnemonic.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupButton(){
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
