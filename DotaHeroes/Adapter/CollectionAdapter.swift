//
//  CollectionAdapter.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol CollectionAdapterDelegate: class {
    func didSelectRole(withRole role: RolesData, indexPath: IndexPath)
    func didSelectHero(withHero hero: HeroesData, indexPath: IndexPath)
}

public class CollectionAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    public unowned let collectionView: UICollectionView
    private(set) var data = [Entity]()
    private var isHeroDetail: Bool = false
    weak var delegate: CollectionAdapterDelegate?

    init(collectionView: UICollectionView, withData data: [Entity], isHeroDetail: Bool = false) {
        self.collectionView = collectionView
        self.data = data
        self.isHeroDetail = isHeroDetail

        super.init()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        // Register Nib
        collectionView.register(UINib(nibName: HeroesCell.reuseIdentifier(),
                                      bundle: nil),
                                forCellWithReuseIdentifier: HeroesCell.reuseIdentifier())
        collectionView.register(UINib(nibName: RolesCell.reuseIdentifier(),
                                      bundle: nil),
                                forCellWithReuseIdentifier: RolesCell.reuseIdentifier())

        collectionView.reloadData()
    }

    func update(withData data: [Entity]) {
        self.data = data
        self.collectionView.reloadData()
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let entity = data[indexPath.row]

        switch entity {
        case let hero as HeroesData:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroesCell.reuseIdentifier(),
                                                                for: indexPath) as? HeroesCell else {
                return UICollectionViewCell()
            }
            cell.hero = hero
            return cell
        case let role as RolesData:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RolesCell.reuseIdentifier(),
                                                                for: indexPath) as? RolesCell else {
                return UICollectionViewCell()
            }
            cell.role = role.role
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let entity = data[indexPath.row]

        switch entity {
        case is HeroesData:
            return HeroesCell.getCellSize(isHeroDetail: isHeroDetail)
        case let role as RolesData:
            return RolesCell.getCellSize(withText: role.role)
        default:
            return .zero
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let entity = data[indexPath.row]

        switch entity {
        case let hero as HeroesData:
            self.delegate?.didSelectHero(withHero: hero, indexPath: indexPath)
        case let role as RolesData:
            self.delegate?.didSelectRole(withRole: role, indexPath: indexPath)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        default:
            break
        }
    }
}
