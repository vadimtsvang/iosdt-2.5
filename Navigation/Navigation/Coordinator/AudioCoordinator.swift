//
//  MediaCoordinator.swift
//  Navigation
//
//  Created by Vadim on 31.05.2022.
//

import Foundation
import UIKit

final class AudioCoordinator: CoordinatorViewController {

    var navigationController: UINavigationController?

    func Start() -> UINavigationController? {
        let factory = Factory(state: .music)
        navigationController = factory.startModule(coordinator: self, data: nil)
        
        return navigationController
    }
}
