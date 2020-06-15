//
//  HeroesCell.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import UIKit

class HeroesCell: UICollectionViewCell {
    @IBOutlet weak var imageView: CachedImageView!
    @IBOutlet weak var heroLabel: UILabel!

    var hero: HeroesData? {
        didSet {
            didSetHero()
        }
    }

    static func getCellSize(isHeroDetail: Bool = false) -> CGSize {
        if isHeroDetail {
            let width = UIScreen.main.bounds.width / 3 - 15
            let height = width + 20
            return CGSize(width: width, height: height)
        }
        let width = UIScreen.main.bounds.width / 2 - 15
        let height = width + 20
        return CGSize(width: width, height: height)
    }

    static func reuseIdentifier() -> String {
        return "HeroesCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.layer.cornerRadius = 4
    }

    private func didSetHero() {
        guard let hero = hero else {
            return
        }
        heroLabel.text = hero.name
        imageView.setCacheImageURL(URL(string: ConstantsManager.imagePrefix + hero.image))
    }
}
