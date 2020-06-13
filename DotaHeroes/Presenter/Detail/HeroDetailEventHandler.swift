//
//  HeroDetailEventHandler.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation

protocol HeroDetailEventHandler: class {
    func getSimilarHeroes(withHero hero: HeroesData)
    func showSimilarHeroes(heroes: [HeroesData])
}
