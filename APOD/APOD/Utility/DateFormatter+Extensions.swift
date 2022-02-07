//
//  DateFormatter.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 06/02/22.
//

import Foundation

extension DateFormatter {

    static var sharedDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        // Add your formatter configuration here
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    static var yyyyMMddFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        // Add your formatter configuration here
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}
