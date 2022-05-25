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
