//
//  PostViewController.swift
//  Navigation
//
//  Created by Vadim on 13.02.2022.
//

import UIKit

class PostViewController: UIViewController {

    private let coordinator: PostCoordinator?

    var postTitle: String?

    init(coordinator: PostCoordinator?, postTitle: String?) {
        self.coordinator = coordinator
        self.postTitle = postTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = postTitle
        var barButton = UIBarButtonItem()
        barButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(tapInfo))
        navigationItem.rightBarButtonItem = barButton
    }

    @objc func tapInfo() {
        let coordinator = InfoCoordinator()
        coordinator.push(controller: navigationController, coordinator: coordinator)
    }
}
