//
//  NetworkHelper.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 29.02.2024.
//

import Foundation
import Alamofire

final class NetworkHelper {
    static let BASE_URL = "https://rickandmortyapi.com/api"
}

enum HTTPMethods {
    case get
    case post
}

extension HTTPMethods {
    func toAlamofire() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}

enum ErrorTypes: String,Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
}


enum RaMPath: String {
    case CHAR = "/character"
}

extension RaMPath {
    func withBaseUrl() -> String {
        return "\(NetworkHelper.BASE_URL)\(self.rawValue)"
    }
}
