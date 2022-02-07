//
//  APODMockDataManager.swift
//  APODTests
//
//  Created by Garima Ashish Bisht on 07/02/22.
//

import UIKit
@testable import APOD

class APODMockDataManager: APODDataManaging {
    
    var response: APODResponseModel {
        let response = APODResponseModel()
        response.title = "Embraced by Sunlight"
        response.explanation = "The similar sunlit crescents were captured in these two separate images. Made at different magnifications, each panel is a composite of stacked video frames taken with a small telescope."
        response.date = "2022-02-03"
        response.url = "https://apod.nasa.gov/apod/image/2202/VenusMoonSamePhase1024.jpg"
        response.hdurl = "https://apod.nasa.gov/apod/image/2202/VenusMoonSamePhase.jpg"
        return response
    }
    
    func fetchAPODData(_ dataSource: APODDataManagerInputDataSource, callback: @escaping (Result<APODResponseModel, Error>) -> Void) {
        callback(.success(response))
    }
    
    
    

}
