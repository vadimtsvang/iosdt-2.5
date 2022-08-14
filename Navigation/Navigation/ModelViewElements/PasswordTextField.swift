//
//  PasswordTextField.swift
//  Navigation
//
//  Created by Vadim on 18.05.2022.
//

import Foundation
import UIKit

protocol PasswordTextFieldDelegate: AnyObject {

    func enterPassword()
}

class PasswordTextField: UITextField {

    //MARK:  delegate
    private weak var delegatTF: PasswordTextFieldDelegate?

    init(delegatTF: PasswordTextFieldDelegate?) {
        self.delegatTF = delegatTF
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .black
        self.layer.cornerRadius = 10
        self.indent(size: 10)
        self.placeholder = "Enter password"
        self.addTarget(self, action: #selector(editPassword), for: .editingChanged)
        self.text = ""
        self.isSecureTextEntry = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func editPassword() {
        delegatTF?.enterPassword()
    }
}
