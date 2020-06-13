//
//  RouterHeroDetail.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit

protocol RouterHeroDetail {

}

extension RouterHeroDetail {
    func pushHeroDetail(fromView view: UIViewController, withHero hero: HeroesData) {
        let heroWireframe = HeroDetailWireframe(hero: hero)
        view.navigationController?.pushViewController(heroWireframe.viewController, animated: true)
    }
}
