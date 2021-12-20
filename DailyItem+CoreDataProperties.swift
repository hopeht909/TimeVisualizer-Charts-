//
//  DailyItem+CoreDataProperties.swift
//  TimeVisualizer(Charts)
//
//  Created by admin on 15/05/1443 AH.
//
//

import Foundation
import CoreData


extension DailyItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyItem> {
        return NSFetchRequest<DailyItem>(entityName: "DailyItem")
    }

    @NSManaged public var time: String?
    @NSManaged public var task: String?

}

extension DailyItem : Identifiable {

}
