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


struct CharacterManager {
    let ts = Date().currentTimeStamp
    
    func fetchCharacter() {
        let hash = (Keys.keyPrivate.rawValue + Keys.keyPublic.rawValue + ts).md5
//        let urlCharacter = "http://gateway.marvel.com/v1/public/comics?ts=\(ts)&apikey=\(Keys.keyPublic.rawValue)&hash=\(hash)"
        let urlCharacter = "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(Keys.keyPublic.rawValue)&hash=\(hash)&limit=50&offset=\(0)"
        performRequest(with: urlCharacter)
    }
    
    func performRequest(with urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("ERROR")
                    return
                }
                
                if let safeData = data {
                    parseJSON(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ characterData: Data) {
        let decoder = JSONDecoder()
        do {
            // let decodedData = try decoder.decode(CharacterData.self, from: characterData)
            //            let id = decodedData.weather[0].id ?? 0
            //            let temp = decodedData.main.temp ?? 0.0
            //            let name = decodedData.name ?? ""
            
            //            let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            //            return weatherModel
        } catch {
            //self.delegate?.didFailWithError(error: error)
            
        }
    }
}
