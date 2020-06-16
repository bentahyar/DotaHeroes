//
//  MockHeroDetailOutput.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
@testable import DotaHeroes

class MockHeroDetailOutput: HeroDetailInteractorOutput {
    var invokedShowSimilarHeroes = false
    var invokedShowSimilarHeroesCount = 0
    var invokedShowSimilarHeroesParameters: (heroes: [HeroesData], Void)?
    var invokedShowSimilarHeroesParametersList = [(heroes: [HeroesData], Void)]()
    func showSimilarHeroes(heroes: [HeroesData]) {
        invokedShowSimilarHeroes = true
        invokedShowSimilarHeroesCount += 1
        invokedShowSimilarHeroesParameters = (heroes, ())
        invokedShowSimilarHeroesParametersList.append((heroes, ()))
    }
}
