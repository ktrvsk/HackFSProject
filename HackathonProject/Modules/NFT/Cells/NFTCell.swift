//
//  NFTCell.swift
//  HackathonProject
//
//  Created by Ksusha on 19.07.2022.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher


final class NFTCell: UICollectionViewCell, Reusable {

//MARK: - Properties
    private let pinterestCollectionView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let openDetailViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonAction), for: UIControl.Event.touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    private var collectionCellModel: NFTCellModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPicturesImageView()
        setupButton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pinterestCollectionView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: NFTCellModel) -> Self {
        collectionCellModel = model
        pinterestCollectionView.kf.setImage(with: URL(string: model.image))
        return self
    }
    
// MARK: - Setup UI Elements
    
    private func setupPicturesImageView() {
        addSubview(pinterestCollectionView)
        pinterestCollectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func setupButton() {
        addSubview(openDetailViewButton)
        openDetailViewButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func addButtonAction(button: UIButton) {
        collectionCellModel?.actionHandler()
    }
}

