//
//  RealmService.swift
//  Navigation
//
//  Created by Vadim on 12.07.2022.
//

import Foundation
import RealmSwift

final class RealmService{

    static let shared = RealmService()

    func fetch() -> Results<AuthModel>?{
        let realm = try? Realm()
        print("Получаем объект ⚠️ \(String(describing: realm?.objects(AuthModel.self)))")
        return realm?.objects(AuthModel.self)
    }

    func save(_ model: AuthModel) {
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(model)
                print("⚠️ \(realm.configuration.fileURL?.absoluteURL as Any)")
            })

        } catch  {
            print(error.localizedDescription)
        }
    }

    func deleteUser(_ model: AuthModel) {
        do {
            let realm = try Realm()
            try realm.write({
                realm.delete(model)
            })

        } catch  {
            print(error.localizedDescription)
        }
    }
}
