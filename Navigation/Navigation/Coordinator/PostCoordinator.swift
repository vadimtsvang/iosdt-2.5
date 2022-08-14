//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Vadim on 18.05.2022.
//

import Foundation
import UIKit

final class PostCoordinator {

    func push(controller: UINavigationController?, coordinator: PostCoordinator) {
        let viewController = PostViewController(coordinator: coordinator, postTitle: "Post")
        viewController.view.backgroundColor = .systemGray5
        controller?.pushViewController(viewController, animated: true)

    }
}
