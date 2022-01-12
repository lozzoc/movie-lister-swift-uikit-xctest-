//
//  NetworkParams.swift
//  MovieBrowser
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

/* add api key to environment , see README for additional information.*/
//fileprivate let apiKey = ProcessInfo.processInfo.environment["themoviedb"]

enum NetworkParams {
    
   
    private enum NetworkBase: String {
        case baseSearch = "https://api.themoviedb.org/3/search/movie"
        case baseImage = "https://image.tmdb.org/t/p/w500"
       
    }
    
    case searchRequest(String)
    case imageRequest(String)
    
    var url: URL? {
        switch self {
        case .searchRequest(let query):
            var components = URLComponents(string: NetworkBase.baseSearch.rawValue)
            components?.queryItems = [URLQueryItem(name: "api_key", value: apiKey), URLQueryItem(name: "query", value: query)]
            return components?.url
        case .imageRequest(let path):
            return URL(string: NetworkBase.baseImage.rawValue + path)

        }
        
    }
    
    
}
