//
//  ViewController.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 19/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

