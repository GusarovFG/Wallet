//
//  LanguageResultCD+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 25.05.2022.
//
//

import Foundation
import CoreData


extension LanguageResultCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LanguageResultCD> {
        return NSFetchRequest<LanguageResultCD>(entityName: "LanguageResultCD")
    }

    @NSManaged public var list: [ListOfLanguageCD]
    @NSManaged public var version: String?

}
