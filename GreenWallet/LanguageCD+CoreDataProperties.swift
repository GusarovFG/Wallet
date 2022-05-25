//
//  LanguageCD+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 25.05.2022.
//
//

import Foundation
import CoreData


extension LanguageCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LanguageCD> {
        return NSFetchRequest<LanguageCD>(entityName: "LanguageCD")
    }

    @NSManaged public var default_language: [LanguageResultCD]
    @NSManaged public var result: [LanguageResultCD]
    @NSManaged public var success: Bool

}
