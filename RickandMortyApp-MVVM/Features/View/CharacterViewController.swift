//
//  ViewController.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 28.02.2024.
//

import UIKit
import Kingfisher

class CharacterViewController: UIViewController {
    //MARK: VARIABLES
    @IBOutlet weak var collectionView: UICollectionView!
    private var characterViewModel: CharacterViewModelProtocol = CharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterViewModel.delegate = self
        characterViewModel.fetchData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
    }
}
extension CharacterViewController: CharacterViewModelOutputProtocol {
    func update() {
        collectionView.reloadData()
        print(characterViewModel.characters!)
    }
    
    func error() {
        print("Error")
    }
}

extension CharacterViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterViewModel.characters?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let char = characterViewModel.characters?.results[indexPath.row],
           let imageURL = URL(string: char.image) {
            DispatchQueue.main.async {
                cell.cellImageView.kf.setImage(with: imageURL)
                cell.cellLabel.text = char.name
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
       
}
