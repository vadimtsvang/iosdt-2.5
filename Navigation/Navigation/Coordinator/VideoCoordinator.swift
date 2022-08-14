//
//  VideoCoordinator.swift
//  Navigation
//
//  Created by Vadim on 03.06.2022.
//

import Foundation
import UIKit

final class VideoCoordinator: CoordinatorViewController {

    var navigationController: UINavigationController?

    func Start()  -> UINavigationController? {
        let factory = Factory(state: .video)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
}
