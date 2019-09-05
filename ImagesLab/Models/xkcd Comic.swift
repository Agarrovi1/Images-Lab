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
    
    static func getComic(from data: Data) -> XkcdComic? {
        do {
            let comic = try JSONDecoder().decode(XkcdComic.self, from: data)
            return comic
        } catch {
            print(error)
        }
        return nil
    }
}
