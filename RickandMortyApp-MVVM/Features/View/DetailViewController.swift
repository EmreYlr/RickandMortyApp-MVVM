//
//  DetailViewController.swift
//  RickandMortyApp-MVVM
//
//  Created by Emre on 2.03.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    var char : Result? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detail"
        print(char!.name)
    }

}
