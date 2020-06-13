//
//  HeroDetailViewController.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController, HeroDetailView {
    var presenter: HeroDetailEventHandler?
    private var hero: HeroesData

    init(hero: HeroesData) {
        self.hero = hero
        super.init(nibName: "HeroDetailViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("Hero Detail View Controller Deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension HeroDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController?.viewControllers.count != nil
    }
}
