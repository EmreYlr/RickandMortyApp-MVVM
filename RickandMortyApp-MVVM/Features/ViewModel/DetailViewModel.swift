//
//  DetailViewModel.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 4.03.2024.
//

import Foundation

protocol DetailViewModelProtocol {
    var char: Result? { get set }
}

final class DetailViewModel {
    var char: Result?
}

extension DetailViewModel: DetailViewModelProtocol {}

