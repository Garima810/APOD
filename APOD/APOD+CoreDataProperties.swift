//
//  APOD+CoreDataProperties.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 06/02/22.
//
//

import Foundation
import CoreData


extension APOD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<APOD> {
        return NSFetchRequest<APOD>(entityName: "APOD")
    }

    @NSManaged public var title: String?
    @NSManaged public var explanation: String?
    @NSManaged public var url: String?
    @NSManaged public var date: String?
    @NSManaged public var hdurl: String?

}

extension APOD : Identifiable {

}
