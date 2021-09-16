//
//  CharacterManager.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 24/08/21.
//

import UIKit

enum Keys: String {
    case keyPublic = "9e25eed081be90e6df9b3092b901514a"
    case keyPrivate = "6c47aae3d4cb830f23c8806d1e19c7ba26ab87b1"
}

enum HeroesAPIURL: String {
    case getHeroes = "https://gateway.marvel.com:443/v1/public/characters"
}

protocol CharacterDelegate: AnyObject {
    func fetchCharacter(characters: [Character])
    func failFetchCharacter(message: String)
    func finishFetchCharacter()
}

class CharacterModel {
    weak var delegate: CharacterDelegate?
    var heroes: [Character] = []

    func getHeroes(offset: Int = 0, nameCharacter: String = ""){
        self.heroes.removeAll()
        let publicKey = Keys.keyPublic.rawValue
        let ts = Date().currentTimeStamp
        let hash = ApiManager.shared.createAPIKey(ts: ts)
        let name = nameCharacter != ""
        let url = HeroesAPIURL.getHeroes.rawValue
        
        let requestURL = name ? url + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&limit=50&offset=\(offset)&name=\(nameCharacter)" : url + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&limit=50&offset=\(offset)"
        
        RequestManager.shared.makeRequest(to: requestURL, method: .get) { (data, error) in
            guard let data = data else { return }
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(CharacterDataWrapper.self, from: data){
                        self.heroes = response.data.results
                        
                        if self.heroes.isEmpty {
                            self.delegate?.failFetchCharacter(message: "Hero not found :(")
                        } else {
                            self.delegate?.finishFetchCharacter()
                        }
                    }
                }
            } else {
                self.delegate?.failFetchCharacter(message: "Failed to find heroes :(")
            }
        }
    }
    
    func configCell(collection: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as? CharacterCollectionViewCell {
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
        
        return UICollectionViewCell()
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, view: UIImageView) -> UIImage {
//        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                view.image = UIImage(data: data)
            }
        }
        return view.image ?? UIImage()
    }
}
