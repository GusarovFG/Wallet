//
//  CoreDataManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 25.05.2022.
//
import CoreData
import Foundation

class CoreDataManager {
    
    static let share = CoreDataManager()
    
    private init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "GreenWallet")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func fetchLanguage() -> [LanguageCD] {
        let fetchRequest: NSFetchRequest<LanguageCD> = LanguageCD.fetchRequest()
        let language = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        return language
    }
    
    func saveLanguage(_ code: String, version: String) {
        let language = LanguageCD(context: persistentContainer.viewContext)
        
        language.languageCode = code
        language.version = version
        saveContext()
    }
    
    func changeLanguage(_ code: String, version: String) {
        let fetchRequest: NSFetchRequest<LanguageCD> = LanguageCD.fetchRequest()
        let languages = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        
        languages[0].languageCode = code
        languages[0].version = version
        saveContext()
    }

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
