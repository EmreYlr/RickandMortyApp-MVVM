//
//  NetworkManager.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 29.02.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request<T: Codable>(from url: URL ,method: HTTPMethods ,completion: @escaping(Swift.Result<T, ErrorTypes>) -> Void){
        AF.request(url, method: method.toAlamofire()).responseDecodable(of: T.self){ response in
            switch response.result{
            case .success(let value):
                completion(.success(value))
            case .failure(_):
                completion(.failure(.invalidURL))
                break
            }
        }
    }
}
