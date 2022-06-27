//
//  Food+CoreDataProperties.swift
//  Trowley
//
//  Created by Jason Kenneth on 27/06/22.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var amount: Int16
    @NSManaged public var expiry: String?
    @NSManaged public var isBought: Bool
    @NSManaged public var listID: Int64
    @NSManaged public var location: Int16
    @NSManaged public var name: String?
    @NSManaged public var unit: String?

}

extension Food : Identifiable {

}
