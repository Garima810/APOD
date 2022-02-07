//
//  FavouriteViewModel.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 06/02/22.
//

import UIKit

class FavouriteViewModel: NSObject {

    private var apodData: [APOD] = [APOD]()
    var favouriteData = [FavoriteDataModel]()
    let screenTitle = "Favourites"
    
    override init() {
        super.init()
    }
    
    func configureFavoriteDetails() {
        guard let data = CoreDataHelper.sharedInstance().getListOfEntityWithName("APOD", withPredicate: nil, sortKey: nil, isAscending: true) as? [APOD] else {
            return
        }
        apodData = data
        favouriteData.removeAll()
        for data in apodData {
            let dataModel = FavoriteDataModel(title: data.title, date: data.date, url: data.url, detail: data.explanation)
              favouriteData.append(dataModel)
        }
    }
    
    var noOfItemsInSection: Int {
        return favouriteData.count
    }
    
    func image(at index: Int) -> FavoriteDataModel {
        return favouriteData[index]
    }
    
}
