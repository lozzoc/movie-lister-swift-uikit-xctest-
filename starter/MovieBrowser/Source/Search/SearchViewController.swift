//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    static func instantiateViewController() -> SearchViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(SearchViewController.self)") as? SearchViewController
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTable: UITableView!
    
    var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movie Search"
        self.movieTable.dataSource = self
        self.movieTable.delegate = self
        self.movieTable.register(MovieTableViewCell.self, forCellReuseIdentifier: "\(MovieTableViewCell.self)")
        
        self.searchViewModel.bind { [weak self] in
            DispatchQueue.main.async {
                self?.movieTable.reloadData()
            }
        }
        
        
        
    }
    
    @IBAction func search(_ sender: Any) {
        guard let text = self.searchBar.text, !text.isEmpty else { return }
        self.searchViewModel.searchMovies(with: text)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieTableViewCell.self)", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(movieViewModel: self.searchViewModel.createMovieViewModel(for: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = MovieDetailViewController.instantiateViewController() else { return }
        detailVC.configure(movieViewModel: self.searchViewModel.createMovieViewModel(for: indexPath.row))
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
