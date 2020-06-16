//
//  MockMainInput.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 15/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
@testable import DotaHeroes

class MockMainInput: MainInteractorInput {
    var invokedGetHeroesAndRoles = false
    var invokedGetHeroesAndRolesCount = 0
    func getHeroesAndRoles() {
        invokedGetHeroesAndRoles = true
        invokedGetHeroesAndRolesCount += 1
    }
    var invokedGetFilteredHeroes = false
    var invokedGetFilteredHeroesCount = 0
    var invokedGetFilteredHeroesParameters: (role: RolesData, Void)?
    var invokedGetFilteredHeroesParametersList = [(role: RolesData, Void)]()
    func getFilteredHeroes(withRole role: RolesData) {
        invokedGetFilteredHeroes = true
        invokedGetFilteredHeroesCount += 1
        invokedGetFilteredHeroesParameters = (role, ())
        invokedGetFilteredHeroesParametersList.append((role, ()))
    }
}
