//
//  MovieDetailViewModel.swift
//  MovieBrowser
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation


class MovieDetailViewModel {
    
    private let movie: Movie
    private let dateFormatter: DateFormatter
    private let networkCaller: NetworkCaller
    
    init(movie: Movie, formatter: DateFormatter, networkCaller: NetworkCaller) {
        self.movie = movie
        self.dateFormatter = formatter
        self.networkCaller = networkCaller
    }
    
    func movieTitle() -> String {
        return self.movie.title
    }
    
    func movieReleaseDate(style: MovieFormat) -> String? {
        if style == .searchCell {
            return self.dateFormatter.movieCellDateFormat(from: self.movie.releaseDate ?? "")
        } else {
            return self.dateFormatter.movieDetailDateFormat(from: self.movie.releaseDate ?? "")
        }
    }
    
    func movieRating() -> String {
        return "\(self.movie.rating)"
    }
    
    func movieDescription() -> String {
        return self.movie.overview
    }
    
    func moviePosterImage(completion: @escaping (Data?) -> Void) {
        guard let imagePath = self.movie.posterImage else {
            completion(nil)
            return
        }
        
        if let imageData = ImageCache.shared.getData(with: imagePath) {
            completion(imageData)
        } else {
            self.networkCaller.getData(url: NetworkParams.imageRequest(imagePath).url, completion: { result in
                switch result {
                case .success(let imageData):
                    completion(imageData)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            })
        }
    }
    
}

