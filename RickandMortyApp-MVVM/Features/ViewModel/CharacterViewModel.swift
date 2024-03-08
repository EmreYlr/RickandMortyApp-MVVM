//
//  CharactersViewModel.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 29.02.2024.
//

import Foundation

protocol CharacterViewModelProtocol {
    var characters: [Result] { get }
    var nextPageUrl : String? { get }
    var delegate: CharacterViewModelOutputProtocol? { get set }
    func fetchData(filterByName name: String?)
}

protocol CharacterViewModelOutputProtocol: AnyObject {
    func update()
    func error()
}

final class CharacterViewModel {
    private(set) var characters: [Result] = []
    private(set) var nextPageUrl: String?
    weak var delegate: CharacterViewModelOutputProtocol?
    
    func fetchData(filterByName name: String?) {
        var parameters: [String: Any] = [:]
        
        if let name {
            characters.removeAll()
            parameters["name"] = name
            nextPageUrl = nil
        }
        
        if let url = URL(string: nextPageUrl ?? "\(RaMPath.CHAR.withBaseUrl())") {
            NetworkManager.shared.request(from: url, method: .get, parameters: parameters) { [weak self] (result: Swift.Result<Character, ErrorTypes>) in
                switch result {
                case .success(let data):
                    self?.characters.append(contentsOf: data.results)
                    self?.nextPageUrl = data.info.next
                    self?.delegate?.update()
                case .failure(let error):
                    print("Hata: \(error)")
                    self?.delegate?.error()
                }
            }
        }
    }
}
extension CharacterViewModel: CharacterViewModelProtocol {}
