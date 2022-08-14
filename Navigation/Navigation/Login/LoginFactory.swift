//
//  LoginFactory.swift
//  Navigation
//
//  Created by Vadim on 22.05.2022.
//

import Foundation

protocol LoginFactory: AnyObject {

    func factory() -> LoginViewControllerDelegate
}

class MyLoginFactory: LoginFactory {

    func factory() -> LoginViewControllerDelegate {
        let inspector = LoginInspector()
        return inspector
    }
}
