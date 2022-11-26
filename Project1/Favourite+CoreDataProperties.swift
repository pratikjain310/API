//
//  Favourite+CoreDataProperties.swift
//  Project1
//
//  Created by ashutosh deshpande on 04/11/2022.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var albumId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var flag: Int32

}

extension Favourite : Identifiable {

}
