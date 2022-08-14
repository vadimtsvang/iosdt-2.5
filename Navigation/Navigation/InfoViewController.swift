//
//  InfoViewController.swift
//  Navigation
//
//  Created by Vadim on 13.02.2022.
//

import UIKit

class InfoViewController: UIViewController{

    private let coordinator: InfoCoordinator?
    private let viewModel: InfoViewModelProtocol?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    lazy var nameResidents: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: String(describing: InfoTableViewCell.self))
        return tableView
    }()

    init(coordinator: InfoCoordinator?,
         viewModel: InfoViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewElements()
    }

    func settingsViewElements() {
        view.addSubviews(titleLabel, planetLabel, nameResidents)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.indent),

            planetLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),
            planetLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.indent),
            planetLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingMargin),

            nameResidents.topAnchor.constraint(equalTo: planetLabel.bottomAnchor, constant: Constants.indent),
            nameResidents.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nameResidents.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nameResidents.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4)
        ])
        titleLabel.text = NetworkManager.title
        planetLabel.text = "Период вращения \(NetworkManager.planetName) вокруг своей звезды состовляет: \(NetworkManager.planetData) дня"
    }
}

extension InfoViewController: UITableViewDelegate {
}

extension InfoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NetworkManager.nameResidents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InfoTableViewCell.self), for: indexPath) as? InfoTableViewCell
        guard let labelCell = cell else { return InfoTableViewCell() }
        labelCell.backgroundColor = .clear
        labelCell.configCell(NetworkManager.nameResidents[indexPath.row])
        return labelCell
    }
}
