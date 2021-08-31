//
//  APIManager.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 24/08/21.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    private init() {}
    
    func createAPIKey(ts: String, publicKey: String = Keys.keyPublic.rawValue, privateKey: String = Keys.keyPrivate.rawValue)
    -> (String){
        let initialStringHash = ts + privateKey + publicKey
        let finalHash = initialStringHash.md5
        print(finalHash)
        return finalHash
    }
}
