//
//  HeroDetailViewController.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController, HeroDetailView {
    @IBOutlet weak var imageView: CachedImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!
    @IBOutlet weak var attrLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!

    var presenter: HeroDetailEventHandler?
    private var hero: HeroesData
    private var adapter: CollectionAdapter?

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
        imageView.setCacheImageURL(URL(string: ConstantsManager.imagePrefix + hero.image))
        typeLabel.text = hero.type
        rolesLabel.text = hero.roles.joined(separator: ", ")
        attrLabel.text = hero.attr
        healthLabel.text = "\(hero.health)"
        attackLabel.text = "\(hero.attack)"
        speedLabel.text = "\(hero.speed)"
        nameLabel.text = hero.name

        presenter?.getSimilarHeroes(withHero: hero)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    // MARK: - View
    func showSimilarHeroes(heroes: [HeroesData]) {
        adapter = CollectionAdapter(collectionView: collectionView, withData: heroes)
        adapter?.delegate = self
    }

    @IBAction func backButtonDidClicked(_ sender: Any) {
        presenter?.popHeroDetailView()
    }
}

extension HeroDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController?.viewControllers.count != nil
    }
}

extension HeroDetailViewController: CollectionAdapterDelegate {
    func didSelectRole(withRole role: RolesData, indexPath: IndexPath) {
        // Do Nothing
    }

    func didSelectHero(withHero hero: HeroesData, indexPath: IndexPath) {
        presenter?.showHeroDetail(withHero: hero)
    }
}
