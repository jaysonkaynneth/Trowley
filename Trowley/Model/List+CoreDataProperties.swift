//
//  List+CoreDataProperties.swift
//  Trowley
//
//  Created by Jason Kenneth on 22/06/22.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isActive: Bool
    @NSManaged public var listID: Int64
    @NSManaged public var foods: NSSet?

}

// MARK: Generated accessors for foods
extension List {

    @objc(addFoodsObject:)
    @NSManaged public func addToFoods(_ value: Food)

    @objc(removeFoodsObject:)
    @NSManaged public func removeFromFoods(_ value: Food)

    @objc(addFoods:)
    @NSManaged public func addToFoods(_ values: NSSet)

    @objc(removeFoods:)
    @NSManaged public func removeFromFoods(_ values: NSSet)

}

extension List : Identifiable {

}
