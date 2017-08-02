//
//  DataManager.swift
//  TopGames
//
//  Created by Marcelo on 01/08/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class DataManager : NSObject {
    
    private override init() { }
    static let shared = DataManager()
    
    var context: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TopGames")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Control support
    
    func createData(json: [JSON]) {
        self.clearData()
        _ = json.map{Game.createGame(json:$0)}
        self.saveContext()
    }
    
    private func clearData() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Game.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    func loadData() -> [Game] {
        var games = [Game]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "viewers", ascending: false)]
        do{
            let results = try context.fetch(fetchRequest)
            games = results as! [Game]
        }catch{
            fatalError("Error is retriving games items")
        }
        return games
    }


}
