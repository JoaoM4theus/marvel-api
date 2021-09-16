//
//  DetailCharacterModel.swift
//  MarvelCharacters
//
//  Created by Softbuilder Hibrido on 15/09/21.
//

import Foundation

class DetailCharacterModel {
    var character: Character?
    
    init(character: Character) {
        self.character = character
    }
    
    func configName() -> String {
        return character?.name ?? ""
    }
    
    func configExtension() -> String {
        return character?.thumbnail?.extension ?? ""
    }
    
    func configImage() -> String {
        return "\(character?.thumbnail?.path ?? "").\(character?.thumbnail?.extension ?? "")"
    }
    
    func configDescription() -> String {
        if character?.description == "" {
             return "Unable to get descriptive information for this hero. Sorry"
        }
        
        return (character?.description)!
    }
    
}
