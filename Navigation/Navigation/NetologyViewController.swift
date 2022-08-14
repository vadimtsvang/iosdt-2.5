//
//  NetologyViewController.swift
//  Navigation
//
//  Created by Vadim on 27.05.2022.
//

import UIKit

class NetologyViewController: UIViewController {

    lazy var netologyWindow: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "net")
        view.layer.borderWidth = 1
        view.isHidden = false
        view.contentMode = .scaleToFill
        return view
    }()

    lazy var buttonNetology: UIButton = {
        let button = UIButton()
        button.setTitle("Узнать подробнее", for: .normal)
        button.setTitleColor( .white , for: .normal)
        button.backgroundColor = UIColor(hex: "#4885CC")
        button.addTarget(self, action: #selector(pushURL), for: .touchUpInside)
        return button
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Потом", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#4885CC")
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()

    lazy var stackButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 1
        stack.backgroundColor = .white
        stack.addArrangedSubview(buttonNetology)
        stack.addArrangedSubview(cancelButton)
        stack.distribution = .fillEqually
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubviews(netologyWindow, stackButton)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            netologyWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            netologyWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            netologyWindow.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            netologyWindow.heightAnchor.constraint(equalToConstant: 300),

            stackButton.leadingAnchor.constraint(equalTo: netologyWindow.leadingAnchor),
            stackButton.trailingAnchor.constraint(equalTo: netologyWindow.trailingAnchor),
            stackButton.bottomAnchor.constraint(equalTo: netologyWindow.bottomAnchor),
            stackButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func cancelAction() {
        self.dismiss(animated: false)
    }

    @objc func pushURL() {
        let url = URL(string: "https://netology.ru")
        guard let url = url else { return }
        UIApplication.shared.open(url)
        self.dismiss(animated: false)
    }
}
