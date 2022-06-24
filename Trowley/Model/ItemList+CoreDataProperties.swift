//
//  ItemList+CoreDataProperties.swift
//  Trowley
//
//  Created by Jason Kenneth on 24/06/22.
//
//

import Foundation
import CoreData


extension ItemList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemList> {
        return NSFetchRequest<ItemList>(entityName: "ItemList")
    }

    @NSManaged public var amount: Int16
    @NSManaged public var isBought: Bool
    @NSManaged public var name: String?
    @NSManaged public var unit: String?
    @NSManaged public var listID: Int64

}

extension ItemList : Identifiable {

}
