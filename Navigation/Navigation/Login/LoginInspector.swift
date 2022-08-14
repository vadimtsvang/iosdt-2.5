//
//  LoginInspector.swift
//  Navigation
//
//  Created by Vadim on 22.05.2022.
//

import Foundation
import FirebaseAuth
import RealmSwift

protocol LoginViewControllerDelegate: AnyObject {

    func checkCredential(email: String,
                         password: String,
                         callback: @escaping (_ success: Bool) -> Void)

    func createUser(email: String,
                    password: String,
                    callback: @escaping (_ success: Bool) -> Void)
}

class LoginInspector: LoginViewControllerDelegate {

    let realm = RealmService()

    func checkCredential(email: String, password: String, callback: @escaping (_ success: Bool) -> Void) {
        CheckerService.shared.checkCredential(email: email, password: password) { success in
            if success {
                callback(true)
                UserDefaults.standard.set(true, forKey: "isLogined")
            } else {
                callback(false)
            }
        }
    }

    func createUser(email: String, password: String, callback: @escaping (_ success: Bool) -> Void) {
        CheckerService.shared.createUser(email: email, password: password) { success in
            if success {
                callback(true)
                let model = AuthModel(email: email, password: password, isLogined: true)
                RealmService.shared.save(model)
            } else {
                callback(false)
            }
        }
    }
}
