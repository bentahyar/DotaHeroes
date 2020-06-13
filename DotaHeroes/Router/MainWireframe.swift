//
//  MainWireframe.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit

class MainWireframe: Wireframe {
    var viewController: UIViewController {
        let view = MainViewController()
        let interactor = MainInteractor(service: HeroesService(),
                                        databaseManager: databaseManager)
        let presenter = MainPresenter(interactor: interactor, router: self, view: view)
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.setNavigationBarHidden(true, animated: true)

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        view.loadViewIfNeeded()

        return navigationController
    }
}
