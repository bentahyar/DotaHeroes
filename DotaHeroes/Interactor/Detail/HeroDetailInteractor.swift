//
//  HeroDetailInteractor.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation

class HeroDetailInteractor: HeroDetailInteractorInput {
    weak var output: HeroDetailInteractorOutput?
    private var databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }

    func getSimilarHeroes(withHero hero: HeroesData) {
        var type = ""
        switch hero.attr {
        case "agi":
            type = "speed"
        case "str":
            type = "attack"
        case "int":
            type = "mana"
        default:
            type = ""
        }

        let heroesPredicate = NSPredicate(format: "attr = %@", hero.attr)
        let heroesSortDescriptor = NSSortDescriptor(key: type, ascending: false)
        let heroes = self.databaseManager.fetch(ofType: HeroesData.self,
                                                sortDescriptors: [heroesSortDescriptor],
                                                withPredicate: heroesPredicate)

        var similarHeroes: [HeroesData] = []

        heroes.forEach { heroData in
            if similarHeroes.count < 3, heroData.heroId != hero.heroId {
                similarHeroes.append(heroData)
            }
        }

        self.output?.showSimilarHeroes(heroes: similarHeroes)
    }
}
