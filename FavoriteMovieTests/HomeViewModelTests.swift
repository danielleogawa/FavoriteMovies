//
//  HomeViewModelTests.swift
//  FavoriteMovieTests
//
//  Created by Danielle Nozaki Ogawa on 2023/05/12.
//

import XCTest
@testable import FavoriteMovie
final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewViewModel?
    
    override func setUpWithError() throws {
        viewModel = HomeViewViewModel(delegate: nil)
    }
    
    func testGetDetailViewModel() async {

    }
}
