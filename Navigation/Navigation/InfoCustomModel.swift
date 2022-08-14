//
//  InfoCustomModel.swift
//  Navigation
//
//  Created by Vadim on 18.05.2022.
//

import Foundation
import UIKit

class ButtonAlert: UIButton {

    var buttonAction: (() -> ())

    init(title: String, titleColor: UIColor, buttonAction: @escaping () -> ()) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.setTitleColor(.systemGray5, for: .highlighted)
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        self.layer.cornerRadius = 10
        self.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func tapButton() {
        buttonAction()
    }
}
