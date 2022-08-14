//
//  DictaphoneCoordinator.swift
//  Navigation
//
//  Created by Vadim on 05.06.2022.
//

import Foundation
import UIKit

final class DictaphoneCoordinator: CoordinatorViewController {

    var navigationController: UINavigationController?

    func Start() -> UINavigationController? {
        let factory = Factory(state: .dictaphone)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
}
