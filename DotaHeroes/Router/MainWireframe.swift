//
//  MainWireframe.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit

class MainWireframe {
    var viewController: UIViewController {
        let view = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter(interactor: interactor, router: self, view: view)
        let navigationController = UINavigationController(rootViewController: view)

        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter

        view.loadViewIfNeeded()

        return navigationController
    }
}
