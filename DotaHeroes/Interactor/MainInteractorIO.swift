//
//  MainInteractorIO.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation

protocol MainInteractorInput: class {
    func getHeroesAndRoles()
}

protocol MainInteractorOutput: class {
    func showHeroesAndRoles(heroes: [HeroesData], roles: [RolesData])
    func showError()
}
