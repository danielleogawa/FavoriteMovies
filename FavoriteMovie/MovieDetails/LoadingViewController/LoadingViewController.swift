//
//  ViewController.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/07/30.
//

import UIKit

class LoadingViewController: UIViewController, LoadProtocol {
    let viewModel: MovieDetailLoadingViewModel
    
    init(viewModel: MovieDetailLoadingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.setLoadDelegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeFromParent()
    }

    func loadedView(_ movie: CompletedMovie) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let viewController = MovieDetailViewController(viewModel: .init(movie: movie))
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
