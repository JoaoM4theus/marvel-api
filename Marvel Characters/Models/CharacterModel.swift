//
//  CharacterManager.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 24/08/21.
//

import Foundation

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
}

class CharacterModel {
    weak var delegate: CharacterDelegate?
    
    func getHeroes(offset: Int = 50){
            
            let publicKey = Keys.keyPublic.rawValue
            let ts = Date().currentTimeStamp
            let hash = ApiManager.shared.createAPIKey(ts: ts)
            
            let url = HeroesAPIURL.getHeroes.rawValue
            
            let requestURL = url + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&limit=50&offset=\(offset)"
            
            RequestManager.shared.makeRequest(to: requestURL, method: .get) { (data, error) in
                guard let data = data else { return }
                if error == nil{
                    do {
                        let decoder = JSONDecoder()
                        if let response = try? decoder.decode(CharacterDataWrapper.self, from: data){
                            let characters = response.data.results
                            if !characters.isEmpty{
                                self.delegate?.fetchCharacter(characters: characters)
                            }else{
                                self.delegate?.failFetchCharacter(message: "Falha ao encontrar heróis")
                            }
                        }
                    }
                }else{
                    self.delegate?.failFetchCharacter(message: "Falha ao encontrar heróis")
                }
            }
        }
}
