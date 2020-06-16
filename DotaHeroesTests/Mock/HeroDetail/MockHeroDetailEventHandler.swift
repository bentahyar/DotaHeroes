//
//  MockHeroDetailEventHandler.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 15/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
@testable import DotaHeroes

class MockHeroDetailEventHandler: HeroDetailEventHandler {
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
    var invokedShowHeroDetail = false
    var invokedShowHeroDetailCount = 0
    var invokedShowHeroDetailParameters: (hero: HeroesData, Void)?
    var invokedShowHeroDetailParametersList = [(hero: HeroesData, Void)]()
    func showHeroDetail(withHero hero: HeroesData) {
        invokedShowHeroDetail = true
        invokedShowHeroDetailCount += 1
        invokedShowHeroDetailParameters = (hero, ())
        invokedShowHeroDetailParametersList.append((hero, ()))
    }
    var invokedPopHeroDetailView = false
    var invokedPopHeroDetailViewCount = 0
    func popHeroDetailView() {
        invokedPopHeroDetailView = true
        invokedPopHeroDetailViewCount += 1
    }
}
