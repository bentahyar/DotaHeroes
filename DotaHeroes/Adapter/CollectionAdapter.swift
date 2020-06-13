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

public class CollectionAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    public unowned let collectionView: UICollectionView
    private(set) var data = [Entity]()

    init(collectionView: UICollectionView, withData data: [Entity]) {
        self.collectionView = collectionView
        self.data = data

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
            return HeroesCell.getCellSize()
        case let role as RolesData:
            return RolesCell.getCellSize(withText: role.role)
        default:
            return .zero
        }
    }
}
