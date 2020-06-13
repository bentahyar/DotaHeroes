//
//  MockMainOutput.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
@testable import DotaHeroes

class MockMainOutput: MainInteractorOutput {
    var invokedShowHeroesAndRoles = false
    var invokedShowHeroesAndRolesCount = 0
    var invokedShowHeroesAndRolesParameters: (heroes: [HeroesData], roles: [RolesData])?
    var invokedShowHeroesAndRolesParametersList = [(heroes: [HeroesData], roles: [RolesData])]()
    func showHeroesAndRoles(heroes: [HeroesData], roles: [RolesData]) {
        invokedShowHeroesAndRoles = true
        invokedShowHeroesAndRolesCount += 1
        invokedShowHeroesAndRolesParameters = (heroes, roles)
        invokedShowHeroesAndRolesParametersList.append((heroes, roles))
    }
    var invokedShowError = false
    var invokedShowErrorCount = 0
    func showError() {
        invokedShowError = true
        invokedShowErrorCount += 1
    }
}
