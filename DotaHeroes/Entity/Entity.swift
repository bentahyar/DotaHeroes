//
//  Entity.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import CoreData

protocol EntityKey: Hashable {
}

protocol Entity {
    static func entityName() -> String
}
