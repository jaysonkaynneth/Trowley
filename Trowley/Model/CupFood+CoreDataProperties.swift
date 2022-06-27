//
//  CupFood+CoreDataProperties.swift
//  Trowley
//
//  Created by Jason Kenneth on 26/06/22.
//
//

import Foundation
import CoreData


extension CupFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CupFood> {
        return NSFetchRequest<CupFood>(entityName: "CupFood")
    }

    @NSManaged public var amount: Int16
    @NSManaged public var expiry: String?
    @NSManaged public var isBought: Bool
    @NSManaged public var listID: Int64
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var unit: String?

}

extension CupFood : Identifiable {

}
