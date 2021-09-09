//
//  ViewController.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 19/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = CharacterModel()
    
    var heroes = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getHeroes()
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.characterLabel.text = heroes[indexPath.row].name
        cell.characterImage.layer.cornerRadius = 15
        
        if heroes[indexPath.row].thumbnail?.extension == "jpg" {
            cell.characterImage.image = downloadImage(from: URL(string: "\(heroes[indexPath.row].thumbnail?.path ?? "").\(heroes[indexPath.row].thumbnail?.extension ?? "")")!, view: cell.characterImage)
        } else {
            cell.characterImage.image = UIImage.gifImageWithURL("\(heroes[indexPath.row].thumbnail?.path ?? "").\(heroes[indexPath.row].thumbnail?.extension ?? "")")
        }
        
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailCharacterViewController {
            vc.name = heroes[indexPath.row].name
            vc.descricao = heroes[indexPath.row].description
            if heroes[indexPath.row].description == "" {
                vc.descricao =  "Unable to get descriptive information for this hero. Sorry"
            }
            vc.image = "\(heroes[indexPath.row].thumbnail?.path ?? "").\(heroes[indexPath.row].thumbnail?.extension ?? "")"
            vc._extension = heroes[indexPath.row].thumbnail?.extension
            
            present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 220)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.heroes.removeAll()
        self.viewModel.getHeroes(nameCharacter: searchBar.text ?? "")
        self.collectionView.reloadData()
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.heroes.removeAll()
            self.viewModel.getHeroes()
            self.collectionView.reloadData()
        }
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
