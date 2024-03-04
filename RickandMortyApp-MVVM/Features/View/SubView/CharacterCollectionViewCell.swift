//
//  CharacterCollectionViewCell.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 2.03.2024.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2
        layer.cornerRadius = 18
        cellImageView.layer.cornerRadius = 18
    }
}
