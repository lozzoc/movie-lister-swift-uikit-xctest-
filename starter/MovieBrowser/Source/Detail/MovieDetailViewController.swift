//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    static func instantiateViewController() -> MovieDetailViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(MovieDetailViewController.self)") as? MovieDetailViewController
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movieViewModel: MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.update()
    }
    
    func configure(movieViewModel: MovieDetailViewModel?) {
        self.movieViewModel = movieViewModel
    }
    
    private func update() {
        self.titleLabel.text = self.movieViewModel?.movieTitle()
        self.releaseLabel.text = "Release Date: \(self.movieViewModel?.movieReleaseDate(style: .detailView) ?? "N/A")"
        self.descriptionLabel.text = self.movieViewModel?.movieDescription()
        
        self.movieViewModel?.moviePosterImage{ [weak self] data in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                self?.posterImageView.contentMode = .scaleAspectFit
                self?.posterImageView.image = UIImage(data: imageData)
            }
        }
        
    }
}
