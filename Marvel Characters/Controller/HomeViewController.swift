//
//  ViewController.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 19/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = CharacterModel()
        
    var heroes = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getHeroes()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.characterLabel.text = heroes[indexPath.row].name
        cell.characterImage.image = UIImage(named: "spiderman")
        cell.characterImage.layer.cornerRadius = 15
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailCharacterViewController {
//            vc.image =
            vc.name = heroes[indexPath.row].name
            vc.descricao = heroes[indexPath.row].description
            present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 220)
    }
}

extension HomeViewController: CharacterDelegate {
    func fetchCharacter(characters: [Character]) {
        DispatchQueue.main.async {
            self.heroes.append(contentsOf: characters)
            self.collectionView.reloadData()
        }
    }
    
    func failFetchCharacter(message: String) {
        print(message)
    }
}
