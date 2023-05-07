//
//  MovieDetailViewController.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/01.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let viewModel: MovieDetailViewModel
    let screen: MovieDetailScreen
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        self.screen = MovieDetailScreen(delegate: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = screen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen.setNavigationController(viewController: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.screen.setBackground()
    }
}
