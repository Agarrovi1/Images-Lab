//
//  Users.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/6/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation

struct Users: Codable {
    let results: [InfoWrapper]
    
    static func getUsers(completionHandler: @escaping (Result<[InfoWrapper],AppError>)->()) {
        let url = "https://randomuser.me/api/?results=50"
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let users = try JSONDecoder().decode(Users.self, from: data)
                    completionHandler(.success(users.results))
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }

    }
}

struct InfoWrapper: Codable {
    let name: Name
    let location: Location
    let phone: String
    let cell: String
    let dob: DateOfBirth
    let picture: Picture
    
    func getFullName() -> String {
        return name.first + " " + name.last
    }
    func getFullNameUppercased() -> String {
        return name.first.firstUppercased + " " + name.last.firstUppercased
    }
    func getFullAddress() -> String {
        return "\(location.street) \(location.city), \(location.state)"
    }
}
struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: String
    let city: String
    let state: String
}

struct Picture: Codable {
    let large: String
    let thumbnail: String
}
struct DateOfBirth: Codable {
    let age: Int
}

extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
