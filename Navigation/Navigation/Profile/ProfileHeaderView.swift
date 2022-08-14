//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Vadim on 15.02.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    private var statusText: String = ""
    private var defaultAvatarPoint: CGPoint?

    static var timerLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.textColor = .black
        userName.text = "James"
        userName.textAlignment = .center
        userName.font = .systemFont(ofSize: 18, weight: .bold)
        return userName
    }()

    var avatarFoneView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.isHidden = true
        view.alpha = 0
        return view
    }()

    lazy var exitAvatarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.contentMode = .scaleToFill
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.gray, renderingMode: .automatic), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeAvatarView), for: .touchUpInside)
        button.alpha = 0
        return button
    }()

    lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.image = UIImage(named: "гомер")
        avatar.clipsToBounds = true
        avatar.layer.borderWidth = 3
        avatar.layer.cornerRadius = 50
        avatar.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        var gesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapAvatar))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        avatar.addGestureRecognizer(gesture)
        avatar.isUserInteractionEnabled = true
        return avatar
    }()

    var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    var buttonStatus: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hex: "#4885CC")
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(nil, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()

    lazy var textFieldStatus: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .white
        text.font = .systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        text.layer.cornerRadius = 12
        text.layer.borderWidth = 1
        text.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: text.frame.height))
        text.leftViewMode = .always
        text.placeholder = "Set status"
        text.adjustsFontSizeToFitWidth = false
        text.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

        return text
    }()

    private func setupConstraints() {

        NSLayoutConstraint.activate([


            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingMargin),
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.indent),

            userName.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),

            buttonStatus.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: Constants.indent),
            buttonStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingMargin),
            buttonStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingMargin),
            buttonStatus.heightAnchor.constraint(equalToConstant: 50),

            statusLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: Constants.trailingMargin),
            statusLabel.bottomAnchor.constraint(equalTo: textFieldStatus.topAnchor, constant: -6),

            textFieldStatus.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            textFieldStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingMargin),
            textFieldStatus.bottomAnchor.constraint(equalTo: buttonStatus.topAnchor, constant: -10),
            textFieldStatus.heightAnchor.constraint(equalToConstant: 40),

            exitAvatarButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            exitAvatarButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            exitAvatarButton.widthAnchor.constraint(equalToConstant: 40),
            exitAvatarButton.heightAnchor.constraint(equalTo: exitAvatarButton.widthAnchor),

            ProfileHeaderView.timerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingMargin),
            ProfileHeaderView.timerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.indent)
        ] )
    }

    func addView() {
        addSubviews(userName, statusLabel, buttonStatus, textFieldStatus, ProfileHeaderView.timerLabel, avatarFoneView, avatar, exitAvatarButton)
        self.setupConstraints()
    }

    func currentUser(user: User) {
        userName.text = user.name
        avatar.image = user.userAvatar
        statusLabel.text = user.userStatus
    }

    @objc func pressButton() {
        if textFieldStatus.text != "" {
            statusLabel.text = textFieldStatus.text
            textFieldStatus.text = ""
            textFieldStatus.resignFirstResponder()
        } else if textFieldStatus.text == "" {
            textFieldStatus.resignFirstResponder()
        }
    }

    func maxLenghtTextField(){
        let maxChar = 24
        if (textFieldStatus.text?.count) != nil {
            if textFieldStatus.text!.count == maxChar {
                textFieldStatus.deleteBackward()
            }
        }
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusText = text
        maxLenghtTextField()
        print(statusText)
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }

    @objc  func didTapAvatar() {
        UIImageView.animate(withDuration: 0.5) {
            self.defaultAvatarPoint = self.avatar.center
            self.avatar.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - self.avatar.center.y)
            self.avatar.transform = CGAffineTransform(scaleX: self.contentView.frame.width / self.avatar.frame.width, y: self.contentView.frame.width / self.avatar.frame.width)
            self.avatar.layer.cornerRadius = 0
            self.avatarFoneView.isHidden = false
            self.avatarFoneView.alpha = 0.9
            ProfileViewController.postTableView.isScrollEnabled = false
            ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
            self.avatar.isUserInteractionEnabled = false
        } completion: { _ in
            UIImageView.animate(withDuration: 0.3) {
                self.exitAvatarButton.alpha = 1
            }
        }
    }

    @objc func closeAvatarView() {
        UIImageView.animate(withDuration: 0.3) {
            self.exitAvatarButton.alpha = 0
        } completion: { _ in
            UIImageView.animate(withDuration: 0.5) {

                guard self.defaultAvatarPoint != nil else { return }
                self.avatar.center = self.defaultAvatarPoint!
                self.avatar.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatar.layer.cornerRadius = self.avatar.frame.width / 2
                self.avatarFoneView.alpha = 0
                ProfileViewController.postTableView.isScrollEnabled = true
                ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
                self.avatar.isUserInteractionEnabled = true
            }
        }
    }
}
