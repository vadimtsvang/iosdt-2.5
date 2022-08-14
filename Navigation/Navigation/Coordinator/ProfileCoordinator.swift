//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Vadim on 14.05.2022.
//

import Foundation
import UIKit

final class ProfileCoordinator: CoordinatorViewController {

    var navigationController: UINavigationController?
    let userService: UserServiceProtocol?
    let userLogin: String?
    var callback: () -> Void

    init(data: (userService: UserServiceProtocol, userLogin: String), callback: @escaping () -> Void) {
        self.userService = data.userService
        self.userLogin = data.userLogin
        self.callback = callback
    }

    func Start() throws -> UINavigationController? {
        let factory = Factory(state: .profile)
        guard let userService = userService,
              let userLogin = userLogin else {
            throw AuthorizationError.badAuthData
        }
        navigationController = factory.startModule(coordinator: self, data: (userService: userService, userLogin: userLogin))
        return navigationController
    }

    // MARK: - TASK 10
    func showNetology() {
        let netology = NetologyViewController()
        netology.modalPresentationStyle = .custom
        self.navigationController?.present(netology, animated: false)
    }

    func exitProfile() {
        callback()
    }
}
