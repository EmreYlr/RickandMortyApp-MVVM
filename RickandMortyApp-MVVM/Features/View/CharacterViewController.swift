//
//  ViewController.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 28.02.2024.
//

import UIKit
import Kingfisher

final class CharacterViewController: UIViewController {
    //MARK: -VARIABLES
    @IBOutlet weak var collectionView: UICollectionView!
    var characterViewModel: CharacterViewModelProtocol = CharacterViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
        refreshControl.addTarget(characterViewModel, action: #selector(loadData),for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    
    @objc func loadData() {
        characterViewModel.fetchData()
        refreshControl.endRefreshing()
    }
    
    private func initLoad(){
        characterViewModel.delegate = self
        characterViewModel.fetchData()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
}
//MARK: -CharacterViewModelOutput
extension CharacterViewController: CharacterViewModelOutputProtocol {
    func update() {
        collectionView.reloadData()
    }
    
    func error() {
        print("Error")
    }
}
