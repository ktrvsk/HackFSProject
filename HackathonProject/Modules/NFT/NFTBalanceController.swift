//
//  NFTBalanceController.swift
//  HackathonProject
//
//  Created by Ksusha on 19.07.2022.
//

import Foundation

import Foundation
import UIKit

protocol NFTBalanceControllerProtocol {
    func setModels(model: [NFTCellModel])
    func openNftDetailController(address: String, name: String, tokenId: String)
}

class NFTBalanceController: UIViewController, NFTBalanceControllerProtocol {
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout  )
        collection.register(NFTCell.self, forCellWithReuseIdentifier: NFTCell.reuseIdentifier)
        return collection
    }()
    
    private var cellModels: [NFTCellModel] = []
    
//    private var testLoyaout = UICollectionViewFlowLayout()
    
    private var presenter: NFTBalancePresenterProtocol = NFTBalancePresenter()
    
    private var layout = PinterestLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        layout.delegate = self
        setupCollectionView()
        setupNavigationBar()
        presenter.viewDidLoad()
    }
    
    func setModels(model: [NFTCellModel]) {
        cellModels = model
        collectionView.reloadData()
    }
    
    func openNftDetailController(address: String, name: String, tokenId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sendNft") as! NFTDetailController
        vc.getNftData(address: address, name: name, tokenId: tokenId)
        navigationController?.pushViewController(vc, animated: true)
    }
    
// MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "NFT"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .gray
        navigationItem.titleView = titleLabel
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension NFTBalanceController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTCell.reuseIdentifier, for: indexPath) as? NFTCell else {
            return .init(frame: .zero)
        }
//        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        return cell.update(with: cellModels[indexPath.row])
    }
    
//    @objc
//    func tap(address: String) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "sendNft") as! NFTDetailController
//        navigationController?.pushViewController(vc, animated: true)
//    }
}

// MARK: - PinterestLayoutDelegate

extension NFTBalanceController: PinterestLayoutDelegate {
    func collectionView(_ collection: UICollectionView, sizeOfPhotoAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}
