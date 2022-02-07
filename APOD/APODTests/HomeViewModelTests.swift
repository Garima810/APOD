//
//  HomeViewModelTests.swift
//  APODUITests
//
//  Created by Garima Ashish Bisht on 07/02/22.
//

import XCTest
@testable import APOD

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    let dataManager = APODMockDataManager()
    var response: APODResponseModel?
    
    override func setUpWithError() throws {
        viewModel = HomeViewModel(with: dataManager)
        viewModel.apodResponse = dataManager.response
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchData() {
        viewModel.fetchImageDetailsforSelectedDate { response in
            XCTAssertNotNil(response)
        }
    }

    func testScreenTitle() {
        XCTAssertEqual(viewModel.screenTitle, "Today's APOD")
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "2022-02-07")
    }
    
    func testTitle() {
        XCTAssertEqual(viewModel.title, "Embraced by Sunlight")
    }
    
    func testDetail() {
        XCTAssertEqual(viewModel.detail, "The similar sunlit crescents were captured in these two separate images. Made at different magnifications, each panel is a composite of stacked video frames taken with a small telescope.")
    }
    
    func testDataSource() {
        XCTAssertEqual(viewModel.dataSource.count, 3)
    }
    
    func testAlreadyFavourites() {
        XCTAssertEqual(viewModel.isAlreadyAddedToFavourites(), false)
    }
    
}
