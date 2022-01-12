//
//  ImageCache.swift
//  MovieBrowser
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation


final class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache: NSCache<NSString, NSData>
    
    private init(cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()) {
        self.cache = cache
    }

}

extension ImageCache {
    
    func getData(with key: String) -> Data? {
        let _key = NSString(string: key)
        guard let _data = self.cache.object(forKey: _key) else { return nil }
        return Data(referencing: _data)
    }
    
    func setData(with key: String, data: Data) {
        let _key = NSString(string: key)
        let _data = NSData(data: data)
        self.cache.setObject(_data, forKey: _key)
    }
    
    
}
