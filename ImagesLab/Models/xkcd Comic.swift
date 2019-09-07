//
//  xkcd Comic.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
struct XkcdComic: Codable {
    let num: Int
    let safe_title: String
    let img: String
    init() {
        num = Int()
        safe_title = String()
        img = String()
    }
    
    static func getComic(from urlString: String,completionHandler: @escaping (Result<XkcdComic,AppError>) -> ()) {
        NetworkManager.shared.fetchData(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let comic = try JSONDecoder().decode(XkcdComic.self, from: data)
                    completionHandler(.success(comic))
                } catch {
                    completionHandler(.failure(.badJSONError))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

class ComicUrlHolder {
    let recentUrl = "https://xkcd.com/info.0.json"
    func getSpecificComicUrl(num:Int) -> String {
        return "https://xkcd.com/\(num)/info.0.json"
    }
    func getComicUrlFromDouble(num:Double) -> String {
        return "https://xkcd.com/\(Int(num))/info.0.json"
    }
}
