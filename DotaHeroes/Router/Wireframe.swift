//
//  Wireframe.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit

protocol Wireframe {
    var viewController: UIViewController { get }
}

extension Wireframe {
    var databaseManager: DatabaseManager {
        guard let coreDataManager = (UIApplication.shared.delegate as? AppDelegate)?
            .coreDataManager else {
                fatalError("Cannot get core data manager.")
        }

        return coreDataManager
    }
}
