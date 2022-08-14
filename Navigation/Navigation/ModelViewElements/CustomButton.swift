//
//  CustomButton.swift
//  Navigation
//
//  Created by Vadim on 18.05.2022.
//

import UIKit

final class CustomButton: UIButton {

    private var buttonAction: (() -> Void)

    init(title: String, titleColor: UIColor, buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        self.backgroundColor = UIColor(hex: "#4885CC")
        self.layer.cornerRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func tapButton() {
        buttonAction()
    }
}
