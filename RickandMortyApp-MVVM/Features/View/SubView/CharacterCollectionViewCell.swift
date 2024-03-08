//
//  CharacterCollectionViewCell.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 2.03.2024.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var cellLoadIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2
        layer.cornerRadius = 18
    }
    
    func mainCellConfiguration(with imageURL: URL, with name: String) {
        cellImageView.layer.cornerRadius = 18
        DispatchQueue.main.async { [self] in
            cellImageView.kf.indicatorType = .activity
            cellImageView.kf.setImage(with: imageURL)
            cellLabel.text = name
        }
    }
    
    func loadCellConfiguration() {
        cellLoadIndicator.startAnimating()
    }
}
