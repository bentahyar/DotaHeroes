//
//  RolesData.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import CoreData

@objc(RolesData)
class RolesData: NSManagedObject, Entity {
    @NSManaged var role: String

    static func entityName() -> String {
        "RolesData"
    }

    func createOrUpdate(withRole role: String, context: NSManagedObjectContext) throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: RolesData.entityName())
        let fetchResult = try context.fetch(request)
        guard let results = fetchResult as? [RolesData],
            results.contains(where: { $0.role == role }) == false else {
            return
        }

        let roleData = NSEntityDescription.insertNewObject(forEntityName:
            RolesData.entityName(), into: context) as? RolesData
        roleData?.role = role
    }
}
