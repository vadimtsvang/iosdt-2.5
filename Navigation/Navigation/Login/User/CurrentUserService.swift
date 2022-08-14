//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Vadim on 22.05.2022.
//

import Foundation
import UIKit

protocol UserServiceProtocol: AnyObject {

    func getUser(name: String) -> User?
}

final class CurrentUserService: UserServiceProtocol {

    private let user: User

    init(name: String, userStatus: String, userAvatar: String) {
        self.user = User(name: name, userStatus: userStatus, userAvatar: UIImage(named: userAvatar))
    }
    
    func getUser(name: String) -> User? {
        if name == user.name {
            return user
        } else {
            return nil
        }
    }
}
