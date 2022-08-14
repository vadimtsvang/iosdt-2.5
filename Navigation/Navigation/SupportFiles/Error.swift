//
//  Error.swift
//  Navigation
//
//  Created by Vadim on 30.05.2022.
//

import Foundation

enum AuthorizationError: Error {
    case badLogin
    case badPassword
    case badAuthData
}
