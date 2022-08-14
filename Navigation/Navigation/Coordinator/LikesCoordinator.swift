//
//  LikesCoordinator.swift
//  Navigation
//
//  Created by Vadim on 04.08.2022.
//

import UIKit

class LikesCoordinator: CoordinatorViewController {

    var navigationController: UINavigationController?

    func Start()  -> UINavigationController? {
        let factory = Factory(state: .likePosts)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }
}
