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
    
    lazy var viewModel: CharacterModel = {
        let obj = CharacterModel()
        obj.delegate = self
        return obj
    }()
    
    var heroes = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accessDelegateDataSource()
        viewModel.getHeroes()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func accessDelegateDataSource(){
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        viewModel.delegate = self
    }
    
    private func reloadData() {
        self.collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.configCell(collection: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailCharacterViewController {
//            vc.name = viewModel.heroes[indexPath.row].name
//            vc.descricao = viewModel.heroes[indexPath.row].description
//            if viewModel.heroes[indexPath.row].description == "" {
//                vc.descricao =  "Unable to get descriptive information for this hero. Sorry"
//            }
//            vc.image = "\(viewModel.heroes[indexPath.row].thumbnail?.path ?? "").\(viewModel.heroes[indexPath.row].thumbnail?.extension ?? "")"
//            vc._extension = viewModel.heroes[indexPath.row].thumbnail?.extension
//
//            present(vc, animated: true, completion: nil)
//        }
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailCharacterViewController {
            vc.viewModel = DetailCharacterModel(character: viewModel.heroes[indexPath.row])
            present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 220)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.heroes.removeAll()
        self.viewModel.getHeroes(nameCharacter: searchBar.text ?? "")
        reloadData()
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.heroes.removeAll()
            self.viewModel.getHeroes()
            self.reloadData()
        }
    }
}

extension HomeViewController: CharacterDelegate {
    func finishFetchCharacter() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func fetchCharacter(characters: [Character]) {
//        DispatchQueue.main.async {
//            self.heroes.append(contentsOf: characters)
//            self.reloadData()
//        }
    }
    
    func failFetchCharacter(message: String) {
        //EMITIR ALERTA
//        self.heroes.removeAll()
//        viewModel.getHeroes()
//        self.collectionView.reloadData()
        print(message)
    }
}
