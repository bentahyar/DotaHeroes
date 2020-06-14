//
//  HeroDetailWireframe.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit

class HeroDetailWireframe: Wireframe, RouterHeroDetail {
    var viewController: UIViewController {
        let view = HeroDetailViewController(hero: hero)
        let interactor = HeroDetailInteractor(databaseManager: databaseManager)
        let presenter = HeroDetailPresenter(interactor: interactor, router: self, view: view)

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        return view
    }

    private var hero: HeroesData
    init(hero: HeroesData) {
        self.hero = hero
    }
}
