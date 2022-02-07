//
//  HomeViewModel.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 05/02/22.
//

import UIKit

enum CellType {
    case header
    case title
    case detail
}

class HomeViewModel {
    
    let numberOfSections = 1
    var apodResponse: APODResponseModel?
    private var dataManager: APODDataManaging
    var dataSource : [CellType] = []
    var selectedDate: Date?
    
    init(with dataManager: APODDataManaging = APODDataManager()) {
        self.dataManager = dataManager
        configureDataSource()
    }
    
    private func configureDataSource() {
        dataSource.append(.header)
        dataSource.append(.title)
        dataSource.append(.detail)

    }
    
    var screenTitle: String {
        let today = DateFormatter.sharedDateFormatter.string(from: Date())
        if let date = selectedDate  {
            let selectDate = DateFormatter.sharedDateFormatter.string(from: date)
            return today == selectDate ? "Today's APOD" : DateFormatter.yyyyMMddFormatter.string(from: date)
        }
        return "Today's APOD"
    }
    
    var noOfRowsInSection: Int {
        return dataSource.count
    }
    
    func cellTypeAt(indexPath: IndexPath) -> CellType {
        return dataSource[indexPath.row]
    }
    
    var headerImage: UIImage {
        if let url = URL(string: self.apodResponse?.url ?? "") {
            let data = try? Data(contentsOf: url)
            if let imageData = data {
                return UIImage(data: imageData) ?? UIImage()
            }
        }
      return UIImage()
    }
    
    var title: String {
        return self.apodResponse?.title ?? ""
    }
    
    var detail: String {
        return self.apodResponse?.explanation ?? ""
    }
    
    func isAlreadyAddedToFavourites() -> Bool {
         let predicate = NSPredicate(format: "title == %@", title)
         if let data = CoreDataHelper.sharedInstance().getListOfEntityWithName("APOD", withPredicate: predicate, sortKey: nil, isAscending: true) as? [APOD], data.count > 0 {
             return true
         }
        return false
    }

    func getInitialData() {
        if let data = CoreDataHelper.sharedInstance().getListOfEntityWithName("APOD", withPredicate:nil, sortKey: nil, isAscending: true) as? [APOD], data.count > 0 {
            self.apodResponse?.title = data.first?.title
            self.apodResponse?.explanation = data.first?.explanation
            self.apodResponse?.date = data.first?.date
            self.apodResponse?.url = data.first?.url

        }
    }
    
    func configureCoreDataEntity(shouldDeleteFromFavourites: Bool) {
         let predicate = NSPredicate(format: "title == %@", title)
         if let data = CoreDataHelper.sharedInstance().getListOfEntityWithName("APOD", withPredicate: predicate, sortKey: nil, isAscending: true) as? [APOD], data.count > 0 {
             if let entity = data.first , shouldDeleteFromFavourites {
                 CoreDataHelper.sharedInstance().deleteObject(entity)
             }
             return
             
         } else if let entity =  CoreDataHelper.sharedInstance().createEntityWithName("APOD", uniqueKey: nil, value: nil) as? APOD {
            entity.date = date
            entity.title = apodResponse?.title
            entity.explanation = apodResponse?.explanation
            entity.url = apodResponse?.url
            entity.hdurl = apodResponse?.hdurl
        }
    }

}

extension HomeViewModel : APODDataManagerInputDataSource {
    
    var date: String? {
        let datestring = DateFormatter.sharedDateFormatter.string(from: selectedDate ?? Date())
        return datestring
    }
    
    var apiKey: String? {
        return "by2mEfCjO4zbT5MeEGaPqgcSLIxD2efRbRyuQNME"
    }
    
    var apodRequestURL: String {
        return "https://api.nasa.gov/planetary/apod"
    }
}

extension HomeViewModel {
    
    func fetchImageDetailsforSelectedDate(_ callback: @escaping(Result<APODResponseModel, Error>) -> Void) {
        
        self.dataManager.fetchAPODData(self) { [weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let apodModel):
                strongSelf.apodResponse = apodModel
                callback(response)
            case .failure(let error):
                print("Error", error.localizedDescription)
                callback(.failure(error))
            }
        }
    }
}

