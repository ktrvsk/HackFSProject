//
//  TokenBalanceController.swift
//  HackathonProject
//
//  Created by Ksusha on 18.07.2022.
//

import UIKit

protocol TokenBalanceControllerProtocol: AnyObject {
    func reloadTable(models: [TokenBalanceCellModel])
    func openSendTransaction(with contractAddress: String)
}

final class TokenBalanceController: UIViewController, TokenBalanceControllerProtocol{

// MARK: - Properties

    var presenter: TokenBalancePresenterProtocol = TokenBalancePresenter()

    private var cellModels: [TokenBalanceCellModel] = []
    var contractAddress: String = ""

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TokenBalanceCell.self, forCellReuseIdentifier: TokenBalanceCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset.top = 10
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.controller = self
        setupTableView()
        setupNavigationBar()
        presenter.viewDidLoad()
    }

// MARK: - Public method
    func reloadTable(models: [TokenBalanceCellModel]) {
        cellModels = models
        tableView.reloadData()
    }
    
    func openSendTransaction(with contractAddress: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sendTransaction") as! SendTokenController
        vc.getTokenContractAddress(with: contractAddress)
        navigationController?.pushViewController(vc, animated: true)
    }

// MARK: - Setup UI Elements

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "TOKEN"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .gray
        navigationItem.titleView = titleLabel
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TokenBalanceController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TokenBalanceCell.reuseIdentifier, for: indexPath) as? TokenBalanceCell
        else {
            return .init(frame: .zero)
        }
        return cell.updateCell(with: cellModels[indexPath.row])
    }
}
