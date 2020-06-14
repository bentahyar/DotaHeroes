//
//  HeroDetailPresenter.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit

class HeroDetailPresenter: HeroDetailEventHandler, HeroDetailInteractorOutput {
    let interactor: HeroDetailInteractorInput
    weak var view: HeroDetailView?

    let router: HeroDetailWireframe

    init(interactor: HeroDetailInteractorInput,
         router: HeroDetailWireframe,
         view: HeroDetailView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

    // MARK: - EventHandler
    func getSimilarHeroes(withHero hero: HeroesData) {
        interactor.getSimilarHeroes(withHero: hero)
    }

    func showHeroDetail(withHero hero: HeroesData) {
        guard let view = view as? UIViewController else {
            return
        }
        router.pushHeroDetail(fromView: view, withHero: hero)
    }

    func popHeroDetailView() {
        guard let view = view as? UIViewController else {
            return
        }
        view.navigationController?.popViewController(animated: true)
    }

    // MARK: - Output
    func showSimilarHeroes(heroes: [HeroesData]) {
        view?.showSimilarHeroes(heroes: heroes)
    }
}
