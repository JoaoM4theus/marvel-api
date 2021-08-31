//
//  RequestManager.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 24/08/21.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}


struct RequestManager {
    static let shared = RequestManager()
    
    private init() {}
    
    func makeRequest(to url: String, method: RequestMethod, completion: @escaping (Data?, String?) -> Void ) {
            
            guard let parsedURL = URL(string: url) else {
                return
            }
            
            var request = URLRequest(url: parsedURL)
            let session = URLSession.shared
            request.httpMethod = method.rawValue
            
            
            session.dataTask(with: request) { (data, response, error) in
                guard let _ = error else {
                    completion(data, nil)
                    return
                }
                completion(nil, error.debugDescription)
                return
            }.resume()
            
            request.httpMethod = method.rawValue
        }
}
