//
//  MainEventHandler.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation

protocol MainEventHandler: class {
    func getHeroesAndRoles()
    func getFilteredHeroes(withRole role: RolesData)
}
