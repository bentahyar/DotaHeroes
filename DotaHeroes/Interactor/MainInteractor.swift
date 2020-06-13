//
//  MainInteractor.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorInput {
    weak var output: MainInteractorOutput?
    private var service: HeroesService
    private var databaseManager: DatabaseManager

    init(service: HeroesService, databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
        self.service = service
    }

    func getHeroesAndRoles() {
        service.heroes(onComplete: { data in
            guard let data = data else {
                return
            }
            self.databaseManager.insert(data: data)
            let heroes = self.databaseManager.fetch(ofType: HeroesData.self)
            let roles = self.databaseManager.fetch(ofType: RolesData.self)

            self.output?.showHeroesAndRoles(heroes: heroes, roles: roles)
        }, onError: { _ in
            self.output?.showError()
        })
    }
}
