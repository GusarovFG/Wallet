//
//  ListOfLanguageCD+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 25.05.2022.
//
//

import Foundation
import CoreData


extension ListOfLanguageCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListOfLanguageCD> {
        return NSFetchRequest<ListOfLanguageCD>(entityName: "ListOfLanguageCD")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var name_btn: String?

}
