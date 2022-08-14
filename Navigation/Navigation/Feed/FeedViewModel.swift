//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Vadim on 17.05.2022.
//

import Foundation
import UIKit

protocol FeedViewModelProtocol: AnyObject {

    func setupConstraints(controller: UIViewController, stackView: UIStackView, labelPasswordCheck: UILabel)
}

final class FeedViewModel: FeedViewModelProtocol {

    func setupConstraints(controller: UIViewController, stackView: UIStackView, labelPasswordCheck: UILabel) {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.widthAnchor, constant: -32),

            labelPasswordCheck.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            labelPasswordCheck.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }
}
