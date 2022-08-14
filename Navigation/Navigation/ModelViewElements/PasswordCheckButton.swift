//
//  PasswordCheckButton.swift
//  Navigation
//
//  Created by Vadim on 18.05.2022.
//

import Foundation
import UIKit

final class PasswordCheckButton: UIButton {

    //MARK: closure
    private var buttonAction: (() -> Void)

    init(buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle("Check password", for: .normal)
        self.setTitleColor(.systemGray3, for: .highlighted)
        self.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(hex: "#4885CC")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func touchButton() {
        buttonAction()
        self.resignFirstResponder()
    }
}
