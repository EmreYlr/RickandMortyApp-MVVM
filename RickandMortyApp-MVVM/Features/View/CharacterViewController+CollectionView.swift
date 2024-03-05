//
//  CharacterViewController+CollectionView.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 4.03.2024.
//

import Foundation
import UIKit

//https://rickandmortyapi.com/api/character/?name=rick -> Filter URL

//MARK: -CollectionView
extension CharacterViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterViewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        let char = characterViewModel.characters[indexPath.row]
        if let imageURL = URL(string: char.image) {
            DispatchQueue.main.async {
                cell.cellImageView.kf.indicatorType = .activity
                cell.cellImageView.kf.setImage(with: imageURL)
                cell.cellLabel.text = char.name
//                if char.status == "Alive"{
//                    cell.layer.borderColor = UIColor(red: 0.48, green: 0.77, blue: 0.62, alpha: 1.00).cgColor
//                }else if char.status == "Dead"{
//                    cell.layer.borderColor = UIColor(red: 1.00, green: 0.68, blue: 0.68, alpha: 1.00).cgColor
//                }else {
//                    cell.layer.borderColor = UIColor.systemGray.cgColor
//                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let char = characterViewModel.characters[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.detailViewModel.char = char
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10)/2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == characterViewModel.characters.count - 1 , characterViewModel.currentPage < characterViewModel.totalPages {
            loadData()
        }
    }
}
