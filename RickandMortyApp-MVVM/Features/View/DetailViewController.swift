//
//  DetailViewController.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 2.03.2024.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    //MARK: -VARIABLES
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    var detailViewModel : DetailViewModelProtocol = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
        backgroundColorCheck()
    }
    
    func initLoad(){
        if let char = detailViewModel.char{
            title = char.name.uppercased()
            let url = URL(string: char.image)
            imageView.kf.setImage(with: url)
            statusLabel.text = char.status
            genderLabel.text = char.gender
            speciesLabel.text = char.species
            originLabel.text = char.origin.name
            locationLabel.text = char.location.name
            typeLabel.text = char.type.isEmpty ? "None" : char.type
        }
    }
    
    func backgroundColorCheck(){
        if let char = detailViewModel.char {
            switch char.status{
            case "Alive":
                view.backgroundColor = UIColor(red: 0.48, green: 0.77, blue: 0.62, alpha: 1.00)
            case "Dead":
                view.backgroundColor = UIColor(red: 1.00, green: 0.68, blue: 0.68, alpha: 1.00)
            default:
                view.backgroundColor = .systemGray
            }
        }
    }
}
