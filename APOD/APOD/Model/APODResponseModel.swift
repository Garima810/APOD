//
//  APODResponseModel.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 05/02/22.
//

import Foundation

class APODResponseModel: NSObject, Decodable {
    
    var date: String?
    var explanation: String?
    var title : String?
    var hdurl: String?
    var url: String?
    var media_type : String?
    var service_version: String?

}
