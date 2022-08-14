//
//  DataBaseError.swift
//  Navigation
//
//  Created by Vadim on 12.07.2022.
//

import Foundation
import RealmSwift

enum DataBaseError: Error {
    case wrongModel
    case error(description: String)
    case unknow
}
