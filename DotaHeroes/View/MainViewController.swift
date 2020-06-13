//
//  MainViewController.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainView {
    @IBOutlet weak var rolesCollectionView: UICollectionView!
    @IBOutlet weak var heroesCollectionView: UICollectionView!

    private var heroesAdapter: CollectionAdapter?
    private var rolesAdapter: CollectionAdapter?

    var presenter: MainEventHandler?

    init() {
        super.init(nibName: "MainViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("Main View Controller Deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter?.getHeroesAndRoles()
    }

    // MARK: - View
    func showHeroesAndRoles(heroes: [HeroesData], roles: [RolesData]) {
        heroesAdapter = CollectionAdapter(collectionView: heroesCollectionView, withData: heroes)
        rolesAdapter = CollectionAdapter(collectionView: rolesCollectionView, withData: roles)

        heroesAdapter?.delegate = self
        rolesAdapter?.delegate = self

        // Set selected item at all when first load
        rolesCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
    }

    func showError() {
        debugPrint("Error")
    }

    func showFilteredHeroes(heroes: [HeroesData]) {
        self.heroesAdapter?.update(withData: heroes)
    }
}

extension MainViewController: CollectionAdapterDelegate {
    func didSelectRole(withRole role: RolesData, indexPath: IndexPath) {
        presenter?.getFilteredHeroes(withRole: role)
    }

    func didSelectHero(withHero hero: HeroesData, indexPath: IndexPath) {

    }
}
