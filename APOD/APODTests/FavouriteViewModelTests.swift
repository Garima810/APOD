//
//  FavouriteViewModelTests.swift
//  APODUITests
//
//  Created by Garima Ashish Bisht on 07/02/22.
//

import XCTest

@testable import APOD

class FavouriteViewModelTests: XCTestCase {
    
    var viewModel: FavouriteViewModel!

    override func setUpWithError() throws {
        viewModel = FavouriteViewModel()
        let firstModel = FavoriteDataModel(title: "Blue Moon", date: "2022-02-07", url: "https://apod.nasa.gov/apod/image/2202/NGC4651_CFHT_960.jpg", detail: "It's raining stars.  What appears to be a giant cosmic umbrella is now known to be a tidal stream of stars stripped from a small satellite galaxy.")
        let secondModel = FavoriteDataModel(title: "Galxy Stars", date: "2022-02-06", url: "https://apod.nasa.gov/apod/image/2202/NGC4651_CFHT_960.jpg", detail: "It's raining stars.  What appears to be a giant cosmic umbrella is now known to be a tidal stream of stars stripped from a small satellite galaxy.")
        let thirdModel = FavoriteDataModel(title: "Embraced by Sunlight", date: "2022-02-03", url: "https://apod.nasa.gov/apod/image/2202/VenusMoonSamePhase1024.jpg", detail: "It's raining stars.  What appears to be a giant cosmic umbrella is now known to be a tidal stream of stars stripped from a small satellite galaxy.")
        viewModel.favouriteData = [firstModel,secondModel,thirdModel]
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testScreenTitle() {
        XCTAssertEqual(viewModel.screenTitle, "Favourites")
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(viewModel.noOfItemsInSection, 3)
    }
    
    func testImageAtSection() {
        XCTAssertEqual(viewModel.image(at: 0).date, viewModel.favouriteData.first?.date)
        XCTAssertEqual(viewModel.image(at: 0).title, viewModel.favouriteData.first?.title)
        XCTAssertEqual(viewModel.image(at: 0).detail, viewModel.favouriteData.first?.detail)


    }
    
}
