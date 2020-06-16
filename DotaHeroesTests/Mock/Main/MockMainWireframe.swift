//
//  MockMainWireframe.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 15/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit
@testable import DotaHeroes

class MockMainWireframe: MainWireframe {
    var invokedViewControllerGetter = false
    var invokedViewControllerGetterCount = 0
    var stubbedViewController: UIViewController!
    override var viewController: UIViewController {
        invokedViewControllerGetter = true
        invokedViewControllerGetterCount += 1
        return stubbedViewController
    }
}
