//
//  CharactersViewModel.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 29.02.2024.
//

import Foundation

protocol CharacterViewModelProtocol {
    var characters: [Result] { get }
//    var totalPages : Int { get }
//    var currentPage : Int { get }
    var nextPageUrl : String? { get }
//    var filterNextPageUrl : String? { get }
    var searching: Bool { get }
    var delegate: CharacterViewModelOutputProtocol? { get set }
    func fetchData()
//    func filterFetchData(with name: String)
}

protocol CharacterViewModelOutputProtocol: AnyObject {
    func update()
    func error()
}

final class CharacterViewModel {
    private(set) var characters: [Result] = []
//    private(set) var totalPages: Int = 0
//    private(set) var currentPage = 1
    private(set) var nextPageUrl: String?
//    private(set) var filterNextPageUrl: String?
    private(set) var searching: Bool = false
    weak var delegate: CharacterViewModelOutputProtocol?
    
    func fetchData() {
        if let url = URL(string: nextPageUrl ?? "\(RaMPath.CHAR.withBaseUrl())"){
            NetworkManager.shared.request(from: url, method: .get) { [weak self] (result: Swift.Result<Character, ErrorTypes>) in
                switch result {
                case .success(let data):
                    self?.characters
                        .append(contentsOf: data.results)
//                    self?.totalPages = data.info.pages
//                    self?.currentPage += 1
                    self?.nextPageUrl = data.info.next
                    self?.delegate?.update()
                case .failure(let error):
                    print("Hata: \(error)")
                    self?.delegate?.error()
                }
            }
        }
    }
    
//    func filterFetchData(with name: String) {
//        if let url = URL(string: filterNextPageUrl ?? "\(RaMPath.CHAR.withBaseUrl())?name=\(name)"){
//            
//        }
//    }
}
extension CharacterViewModel: CharacterViewModelProtocol {}
