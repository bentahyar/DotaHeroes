//
//  MockHeroDetailInput.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 15/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
@testable import DotaHeroes

class MockHeroDetailInput: HeroDetailInteractorInput {
    var invokedGetSimilarHeroes = false
    var invokedGetSimilarHeroesCount = 0
    var invokedGetSimilarHeroesParameters: (hero: HeroesData, Void)?
    var invokedGetSimilarHeroesParametersList = [(hero: HeroesData, Void)]()
    func getSimilarHeroes(withHero hero: HeroesData) {
        invokedGetSimilarHeroes = true
        invokedGetSimilarHeroesCount += 1
        invokedGetSimilarHeroesParameters = (hero, ())
        invokedGetSimilarHeroesParametersList.append((hero, ()))
    }
}
