//
//  NetworkManager.swift
//  MovieBrowser
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit


protocol NetworkCaller {
    func getModel<T: Decodable>(url: URL?, completion: @escaping (Result<T, Error>) -> Void)
    func getData(url: URL?, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManager {
    
    let session: Session
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager: NetworkCaller {
    
    func getModel<T: Decodable>(url: URL?, completion: @escaping (Result<T, Error>) -> Void) {
        
        
        guard let url = url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        self.session.dataRequest(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let hResponse = response as? HTTPURLResponse, !(200..<300).contains(hResponse.statusCode) {
                completion(.failure(NetworkError.statusFailure(hResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                print(error)
                completion(.failure(error))
            }
            
        }
        
    }
    
    
    func getData(url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        self.session.dataRequest(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let hResponse = response as? HTTPURLResponse, !(200..<300).contains(hResponse.statusCode) {
                completion(.failure(NetworkError.statusFailure(hResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            completion(.success(data))
        }
        
        
    }
    
    
}
