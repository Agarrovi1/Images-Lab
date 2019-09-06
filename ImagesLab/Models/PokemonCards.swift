//
//  PokemonCards.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/6/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation

struct PokemonCards: Codable {
    let cards: [Cards]
    
    static func getCards(completionHandler: @escaping (Result<[Cards],AppError>) -> () ) {
        let url = "https://api.pokemontcg.io/v1/cards"
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let pokeCards = try JSONDecoder().decode(PokemonCards.self, from: data)
                    completionHandler(.success(pokeCards.cards))
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}

struct Cards: Codable {
    let name: String
    let supertype: String
    let subtype: String
    let types: [String]?
    let weaknesses: [Weakness]?
    let imageUrl: String
    let imageUrlHiRes: String
    let set: String
}
struct Weakness: Codable {
    let type: String
    let value: String
}

func filterCards(containing str:String, arr: [Cards]) -> [Cards] {
    return arr.filter({$0.name.lowercased().contains(str.lowercased())})
}
