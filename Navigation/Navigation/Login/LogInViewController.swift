//
//  LogInViewController.swift
//  Navigation
//
//  Created by Vadim on 04.03.2022.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    var delegate: LoginViewControllerDelegate?

    let coordinator = RootCoordinator()

    var callback: (_ userData: (userService: UserServiceProtocol, userLogin: String)) -> Void
    private let minLenght = 6

    private lazy var loginScrollView: UIScrollView = {
        let loginScrollView = UIScrollView()
        return loginScrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()

    private lazy var imageVK: UIImageView = {
        let imageVK = UIImageView()
        imageVK.image = UIImage(named: "logo")
        return imageVK
    }()

    private lazy var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.distribution = .fillProportionally
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        return stack
    }()

    private lazy var loginTF: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.placeholder = "Email or phone"
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.returnKeyType = .done
        return login
    }()

    private lazy var passwordTF: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = true
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.returnKeyType = .done
        return password
    }()


    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        if let image = UIImage(named: "blue_pixel") {
            loginButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
        }
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(pressLogIn), for: .touchUpInside)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        return loginButton
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Don't have an account? Register!", for: .normal)
        button.setTitleColor(UIColor(hex: "#4885CC"), for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
    }()


    init(callback: @escaping (_ userData: (userService: UserServiceProtocol, userLogin: String)) -> Void) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        loginTF.delegate = self
        passwordTF.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        authSignIn()

        let currentUser = RealmService.shared.fetch()?.last
        guard currentUser != nil else {
            print("currentUser nil")
            return
        }
        passwordTF.text = currentUser?.password
        loginTF.text = currentUser?.email
    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([

            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),

            imageVK.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            imageVK.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageVK.heightAnchor.constraint(equalToConstant: 100),
            imageVK.widthAnchor.constraint(equalToConstant: 100),

            loginStackView.topAnchor.constraint(equalTo: imageVK.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),

            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: Constants.indent),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 1),
            registerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),

        ])
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubviews(loginScrollView)
        loginScrollView.addSubviews(contentView)
        contentView.addSubviews(imageVK, loginStackView, loginButton, registerButton)
        loginStackView.addArrangedSubview(loginTF)
        loginStackView.addArrangedSubview(passwordTF)
        setupConstraints()

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTF.becomeFirstResponder()
        loginTF.resignFirstResponder()
        passwordTF.becomeFirstResponder()
        passwordTF.resignFirstResponder()
        return true;
    }

    @objc private func pressLogIn() {
        guard
            let email = loginTF.text,
            let password = passwordTF.text
        else { return }

        self.delegate?.checkCredential(email: email, password: password, callback: { [weak self] success in
            if success {
                let userService = CurrentUserService(name: "Vadim",
                                                     userStatus: "Thinking out loud",
                                                     userAvatar: "гомер")
                self?.callback((userService: userService, userLogin: email))
                print("success")
            } else {
                self?.checkPassword(message: "Заполните все поля для входа")
                print("error")
            }
        })
    }


    @objc func registerAction() {
        guard
            let email = loginTF.text,
            let password = passwordTF.text
        else { return }

        self.delegate?.createUser(email: email, password: password, callback: { [weak self] success in
            if success == true {
                print("user created")
            } else {
                self?.checkPassword(message: "Заполните все поля для регистрации")
                print("error")
            }
        })

    }

    @objc private func tap() {
         loginTF.resignFirstResponder()
         passwordTF.resignFirstResponder()
     }

    @objc private func keyboardShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentOffset.y = kbdSize.height - (loginScrollView.frame.height - loginButton.frame.minY) + 50
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }

    @objc private func keyboardHide(notification: NSNotification) {
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

extension LogInViewController {

    private func checkPassword(message: String) {
        guard let login = loginTF.text else { return }
        guard let password = passwordTF.text else { return }
        if login.isEmpty || password.isEmpty {
            let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ОК", style: .default)
            alert.addAction(alertAction)
            present(alert, animated: true)
            return
        } else if password.count < minLenght {
            let alert = UIAlertController(title: "Внимание", message: "Минимальная длина пароля 6 символов", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ОК", style: .default)
            alert.addAction(alertAction)
            present(alert, animated: true)
            return
        }
    }
}

extension LogInViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !string.contains(where: {$0 == " " || $0 == "#"})
    }
}

extension LogInViewController {

    func authSignIn() {

        if UserDefaults.standard.bool(forKey: "isLogined") {
            let userService = CurrentUserService(name: "Vadim",
                                                 userStatus: "Thinking out loud",
                                                 userAvatar: "гомер")
            self.callback((userService: userService, userLogin: loginTF.text!))
        }

    }
}
