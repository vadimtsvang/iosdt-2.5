//
//  GeneralCoordinator.swift
//  Navigation
//
//  Created by Vadim on 14.05.2022.
//

import Foundation
import UIKit

enum StateAuthorization {
    case authorized
    case notAuthorized
}

protocol GeneralCoordinator: AnyObject {

    func startApplication(userData: (userService: UserServiceProtocol, userLogin: String)?, stateAuthorization: StateAuthorization) -> UIViewController
}

protocol CoordinatorViewController: AnyObject {
    var navigationController: UINavigationController? { get set }
    func Start() throws -> UINavigationController?
}

final class RootCoordinator: GeneralCoordinator {

    func startApplication(userData: (userService: UserServiceProtocol, userLogin: String)?, stateAuthorization: StateAuthorization) -> UIViewController {
        let tabBarcontroller = MainTabBarController(coordinator: self, stateAuthorization: .notAuthorized, userData: userData)
            return tabBarcontroller
        }
}
