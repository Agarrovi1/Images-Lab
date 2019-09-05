//
//  NetworkManager.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    func fetchData(urlString: String,completionHandler: @escaping (Result<Data,AppError>) -> ()) {
        
    }
}
