//
//  DatabaseManager.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager: NSObject {
    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer

        super.init()
    }

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint("Error when saving \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetch<T: Entity>(ofType: T.Type) -> [T] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName())
        request.returnsObjectsAsFaults = false

        var entities = [T]()
        do {
            let fetchResult = try persistentContainer.viewContext.fetch(request)

            for data in fetchResult {
                if let entity = data as? T {
                    entities.append(entity)
                }
            }
        } catch {
            debugPrint("Error when fetching")
        }

        return entities
    }
}
