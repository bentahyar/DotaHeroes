//
//  HeroDetailPresenter.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation

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
}
