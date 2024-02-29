//
//  ViewController.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 28.02.2024.
//

import UIKit

class CharacterViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: VARIABLES
    private var characterViewModel: CharacterViewModelProtocol = CharacterViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        characterViewModel.delegate = self
        characterViewModel.fetchData()
    }
}
extension CharacterViewController: CharacterViewModelOutputProtocol {
    func update() {
        print(characterViewModel.characters!)
    }
    
    func error() {
        print("Error")
    }
}

