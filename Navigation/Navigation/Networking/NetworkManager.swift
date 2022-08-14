//
//  NetworkManager.swift
//  Navigation
//
//  Created by Vadim on 18.06.2022.
//

import Foundation

// MARK: - TASK 1.1 iosdt
class NetworkManager {

    static var shared = NetworkManager()
    
    static private(set) var title: String = ""
    static private(set) var planetData = ""
    static private(set) var planetName = ""
    static private(set) var nameResidents = [String]()


    // MARK: - TASK 1.2 iosdt, part 1
    private let urlForTitle = "https://jsonplaceholder.typicode.com/todos/2"
    private let urlForDataPlanet = "https://swapi.dev/api/planets/1"

    private func getDataForTitle() {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/2") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url ) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let serializedDictionary = try JSONSerialization.jsonObject(with: data, options: [])
                guard let dictionary = serializedDictionary as? [String : Any] else { return }
                guard let title = dictionary["title"] as? String else { return }
                NetworkManager.title = title.firstUppercased
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    private func getDataPlanet() {
        guard let url = URL(string: urlForDataPlanet) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let dataJSON = try decoder.decode(Planet.self, from: data)
                NetworkManager.planetData = dataJSON.orbitalPeriod.firstUppercased
                NetworkManager.planetName = dataJSON.name
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    // MARK: - TASK 1.2 iosdt, part 2
    private func getURLNameResidents() {
        guard let url = URL(string: urlForDataPlanet) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let dataJSON = try decoder.decode(Planet.self, from: data)
                let residentsURLArray = dataJSON.residents
                for resident in residentsURLArray {
                    self.getNameResidents(resident)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    private func getNameResidents(_ url: String) {
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let dataJson = try JSONDecoder().decode(Resident.self, from: data)
                NetworkManager.nameResidents.append(dataJson.name)
                print(NetworkManager.nameResidents)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    func getDataAll() {
        getDataForTitle()
        getDataPlanet()
        getURLNameResidents()
    }
}
