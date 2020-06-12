//
//  MockPersistentContainer.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import CoreData

class MockPersistentContainer {
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DotaHeroes")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
}
