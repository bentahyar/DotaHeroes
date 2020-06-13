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
}
