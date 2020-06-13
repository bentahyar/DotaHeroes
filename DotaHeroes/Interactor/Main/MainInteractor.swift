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
        let heroesSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let rolesSortDescriptor = NSSortDescriptor(key: "role", ascending: true)
        let heroes = self.databaseManager.fetch(ofType: HeroesData.self, sortDescriptors: [heroesSortDescriptor])
        let roles = self.databaseManager.fetch(ofType: RolesData.self, sortDescriptors: [rolesSortDescriptor])
        guard heroes.isEmpty == true, roles.isEmpty == true else {
            self.output?.showHeroesAndRoles(heroes: heroes, roles: roles)
            return
        }

        service.heroes(onComplete: { data in
            guard let data = data else {
                return
            }
            self.databaseManager.insert(data: data)
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            let rolesSortDescriptor = NSSortDescriptor(key: "role", ascending: true)
            let heroes = self.databaseManager.fetch(ofType: HeroesData.self, sortDescriptors: [sortDescriptor])
            let roles = self.databaseManager.fetch(ofType: RolesData.self, sortDescriptors: [rolesSortDescriptor])

            self.output?.showHeroesAndRoles(heroes: heroes, roles: roles)
        }, onError: { _ in
            self.output?.showError()
        })
    }

    func getFilteredHeroes(withRole role: RolesData) {
        guard role.role != "All" else {
            let heroesSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            let heroes = self.databaseManager.fetch(ofType: HeroesData.self, sortDescriptors: [heroesSortDescriptor])
            self.output?.showFilteredHeroes(heroes: heroes)
            return
        }
        let heroesSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let heroes = self.databaseManager.fetch(ofType: HeroesData.self, sortDescriptors: [heroesSortDescriptor])
        let filteredHeroes = heroes.filter({ $0.roles.contains(role.role) })

        self.output?.showFilteredHeroes(heroes: filteredHeroes)
    }
}
