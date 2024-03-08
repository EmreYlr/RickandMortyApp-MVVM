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
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
        configureSearchController()
    }
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Character By Name"
    }
    
    @objc func loadData() {
        characterViewModel.fetchData(filterByName: nil)
        refreshControl.endRefreshing()
    }
    
    private func initLoad(){
        characterViewModel.delegate = self
        characterViewModel.fetchData(filterByName: nil)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        refreshControl.addTarget(characterViewModel, action: #selector(loadData),for: .valueChanged)
        collectionView?.refreshControl = refreshControl
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

//MARK: -SearchBarController
extension CharacterViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            characterViewModel.fetchData(filterByName: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        characterViewModel.fetchData(filterByName: nil)
    }
    
    
}
