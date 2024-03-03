//
//  ViewController.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 28.02.2024.
//

import UIKit
import Kingfisher

final class CharacterViewController: UIViewController {
    //MARK: VARIABLES
    @IBOutlet weak var collectionView: UICollectionView!
    private var characterViewModel: CharacterViewModelProtocol = CharacterViewModel()
    
    var currentPage = 1
    var totalPages = 20 //Değişecek
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    @objc func loadData() {
        currentPage += 1
        characterViewModel.fetchData(pageNum: currentPage)
        refreshControl.endRefreshing()
    }
    
    private func initLoad(){
        characterViewModel.delegate = self
        characterViewModel.fetchData(pageNum: currentPage)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
}
//MARK: -CharacterViewModel
extension CharacterViewController: CharacterViewModelOutputProtocol {
    func update() {
        collectionView.reloadData()
        //print(characterViewModel.characters)
    }
    
    func error() {
        print("Error")
    }
}

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
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let char = characterViewModel.characters[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.char = char
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let cntr = characterViewModel.characters.count
        if indexPath.item == cntr - 1 , currentPage < totalPages {
            loadData()
        }
        
        
    }
       
}
