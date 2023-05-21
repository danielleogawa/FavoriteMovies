//
//  NetworkTests.swift
//  FavoriteMovieTests
//
//  Created by Danielle Nozaki Ogawa on 2023/05/16.
//

import XCTest
@testable import FavoriteMovie

final class NetworkTests: XCTestCase {

    func testRequestData() throws {
        let url = Request.getUrl(with: .discover, urlPath: .onTheatres)
        let exepectation = expectation(description: "Movie List")
        Request.request(url: url, expecting: List.self) { result in
            switch result {
            case .success(let movies):
                XCTAssertNotEqual(movies.results?.count, 0)
            case .failure(let error):
                XCTAssertNil(error)
            }
            exepectation.fulfill()

        }
        wait(for: [exepectation])
    }
    
    func testRequestImage() throws {
        let url = Request.getUrl(with: .discover, urlPath: .onTheatres)
        let exepectationMoviesList = expectation(description: "Movie List")
        Request.request(url: url, expecting: List.self) { result in
            switch result {
            case .success(let movies):
                Request.getImage(movie: movies.results?[0]) { image in
                    XCTAssertNotNil(image)
                }
            case .failure(let error):
                XCTAssertNil(error)
            }
            exepectationMoviesList.fulfill()
        }

        wait(for: [exepectationMoviesList])
    }
    
}
