//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Vadim on 14.05.2022.
//

import Foundation
import UIKit

final class FeedCoordinator: CoordinatorViewController {

    var navigationController: UINavigationController?

    func Start() -> UINavigationController? {
        let factory = Factory(state: .feed)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
}
