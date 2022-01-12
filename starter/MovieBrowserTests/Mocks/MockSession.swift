//
//  MockSession.swift
//  MovieBrowserTests
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation
@testable import MovieBrowser

class MockSession: Session {
    
    func dataRequest(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if url.absoluteString.contains("Victory") {
                guard let path = Bundle(for: NetworkManagerTests.self).path(forResource: "MovieData", ofType: "json") else {
                    completion(nil, nil, nil)
                    return
                }
                let url = URL(fileURLWithPath: path)
                let data = try? Data(contentsOf: url)
                var response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
                completion(data, response, nil)
            } else {
                completion(nil, nil, NetworkError.dataFailure)
            }
        }
        
    }
    
}
