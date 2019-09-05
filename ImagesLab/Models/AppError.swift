//
//  AppError.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
enum AppError: Error {
    case badJSONError
    case networkError
    case noDataError
    case noResponse
    case notFound
    case unauthorized
    case badUrl
    case badHTTPResponse
    case badImageData
    case other(rawError: String)
}
