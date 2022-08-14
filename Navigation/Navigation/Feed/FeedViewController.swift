//
//  FeedViewController.swift
//  Navigation
//
//  Created by Vadim on 12.02.2022.
//

import UIKit

class FeedViewController: UIViewController {


    private let coordinator: FeedCoordinator?

    private let viewModel: FeedViewModelProtocol?

    private var passwordText: String?

    private lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.alpha = 0
        return label
    }()

    private lazy var firstButton: CustomButton = {
        let firstButton = CustomButton(title: "First Button", titleColor: .white) { [weak self] in
            let coordinator = PostCoordinator()
            coordinator.push(controller: self?.navigationController, coordinator: coordinator)
        }
        return firstButton
    }()

    private lazy var secondButton: CustomButton = {
        let secondButton = CustomButton(title: "Second Button", titleColor: .white) { [weak self] in
            let coordinator = PostCoordinator()
            coordinator.push(controller: self?.navigationController, coordinator: coordinator)

        }
        return secondButton
    }()

    private lazy var checkPasswordButton: PasswordCheckButton = {
        let button = PasswordCheckButton { [weak self] in
            Password.shared.check(self!.passwordText ?? "")
            self?.passwordTF.resignFirstResponder()
            
        }
        return button
    }()

    private lazy var passwordTF: PasswordTextField = {
        let text = PasswordTextField(delegatTF: self)
        return text
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .white
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.addArrangedSubview(passwordTF)
        stackView.addArrangedSubview(checkPasswordButton)
        stackView.distribution = .fillEqually
        return stackView
    }()


    init(coordinator: FeedCoordinator?,
         viewModel: FeedViewModelProtocol?
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubviews(stackView, checkLabel)
        NotificationCenter.default.addObserver(self, selector: #selector(examinationPasswordTrue), name: Notification.Name("true"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(examinationPasswordFalse), name: Notification.Name("false"), object: nil)
        viewModel?.setupConstraints(controller: self,
                                    stackView: stackView,
                                    labelPasswordCheck: checkLabel)
    }

    @objc private func examinationPasswordTrue() {
        showMessage(true)
    }
    @objc private func examinationPasswordFalse() {
        showMessage(false)
    }

    private func showMessage(_ isTrue: Bool) {
        UILabel.animate(withDuration: 0.5) { [weak self] in
            self?.checkLabel.text = isTrue ? "Пароль верный" : "Пароль неверный"
            self?.checkLabel.textColor = isTrue ? .systemGreen : .systemRed
            self?.checkLabel.isHidden = false
            self?.checkLabel.alpha = 1
        } completion: { [self] _ in
            UILabel.animate(withDuration: 2) { [weak self] in
                self?.checkLabel.alpha = 0
            }
        }
        checkLabel.isHidden = false
    }
}

extension FeedViewController: PasswordTextFieldDelegate {

    func enterPassword() {
        passwordText = passwordTF.text!
    }
}
