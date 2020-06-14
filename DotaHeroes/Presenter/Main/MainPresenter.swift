//
//  MainPresenter.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter: MainEventHandler, MainInteractorOutput {
    let interactor: MainInteractorInput
    weak var view: MainView?

    let router: MainWireframe

    init(interactor: MainInteractorInput,
         router: MainWireframe,
         view: MainView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

    // MARK: - EventHandler
    func getHeroesAndRoles() {
        interactor.getHeroesAndRoles()
    }

    func getFilteredHeroes(withRole role: RolesData) {
        interactor.getFilteredHeroes(withRole: role)
    }

    func showHeroDetail(withHero hero: HeroesData) {
        guard let view = view as? UIViewController else {
            return
        }
        router.pushHeroDetail(fromView: view, withHero: hero)
    }

    // MARK: - Output
    func showHeroesAndRoles(heroes: [HeroesData], roles: [RolesData]) {
        view?.showHeroesAndRoles(heroes: heroes, roles: roles)
    }

    func showFilteredHeroes(heroes: [HeroesData]) {
        view?.showFilteredHeroes(heroes: heroes)
    }

    func showError() {
        view?.showError()
    }
}
