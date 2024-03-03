//
//  CharactersViewModel.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 29.02.2024.
//

import Foundation

protocol CharacterViewModelProtocol {
    var characters: [Result] { get }
    var delegate: CharacterViewModelOutputProtocol? { get set }
    func fetchData(pageNum: Int)
}

protocol CharacterViewModelOutputProtocol: AnyObject {
    func update()
    func error()
}

final class CharacterViewModel {
    private(set) var characters: [Result] = []
    weak var delegate: CharacterViewModelOutputProtocol?
    
    func fetchData(pageNum: Int){
        //page kısmını path enuma al
        if let url = URL(string: "\(RaMPath.CHAR.withBaseUrl())?page=\(pageNum)") {
            NetworkManager.shared.request(from: url, method: .get) { [weak self] (result: Swift.Result<Character, ErrorTypes>) in
                switch result {
                case .success(let data):
                    self?.characters
                        .append(contentsOf: data.results)
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
