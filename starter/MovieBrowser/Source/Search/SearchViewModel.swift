//
//  SearchViewModel.swift
//  MovieBrowser
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation


class SearchViewModel {
    
    private var moviesList: [Movie] {
        didSet {
            guard oldValue != moviesList else { return }
            self.updateHandler?()
        }
    }
    private var networkCaller: NetworkCaller
    private let dateFormatter = DateFormatter()
    
    private var updateHandler: (() -> Void)?
    
    init(networkCaller: NetworkCaller = NetworkManager()) {
        self.moviesList = []
        self.networkCaller = networkCaller
    }
    
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
    
    func searchMovies(with query: String) {
        self.networkCaller.getModel(url: NetworkParams.searchRequest(query).url) { [weak self] (result: Result<PageResult, Error>) in
            switch result {
            case .success(let page):
                self?.moviesList = page.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension SearchViewModel {
    
    var count: Int {
        return self.moviesList.count
    }
    
    func createMovieViewModel(for index: Int) -> MovieDetailViewModel? {
        guard index < self.count else { return nil }
        return MovieDetailViewModel(movie: self.moviesList[index], formatter: self.dateFormatter, networkCaller: self.networkCaller)
    }
    
}

