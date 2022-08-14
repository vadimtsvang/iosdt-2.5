//
//  AppDelegate.swift
//  Navigation
//
//  Created by Vadim on 12.02.2022.
//

import UIKit
import AVFoundation
import YoutubePlayer_in_WKWebView
import Foundation
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.overrideUserInterfaceStyle = .light
        self.window?.makeKeyAndVisible()
        let coordinator: GeneralCoordinator = RootCoordinator()
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().barStyle = .default

        FirebaseApp.configure()

        appendArrayPhotos()
        self.window?.rootViewController = coordinator.startApplication(userData: nil, stateAuthorization: .notAuthorized)

        return true
    }
}
