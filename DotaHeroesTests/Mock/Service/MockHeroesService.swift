//
//  MockHeroesService.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
@testable import DotaHeroes

class MockHeroesService: HeroesService {
    var invokedHeroes = false
    var invokedHeroesCount = 0
    var invokedHeroesParameters: (onComplete: OnComplete?, onError: OnError?)?
    var invokedHeroesParametersList = [(onComplete: OnComplete?, onError: OnError?)]()
    var stubbedHeroesError: Error?
    var stubbedHeroesSuccess: Data?
    override func heroes(onComplete: OnComplete?, onError: OnError?) {
        invokedHeroes = true
        invokedHeroesCount += 1
        invokedHeroesParameters = (onComplete, onError)
        invokedHeroesParametersList.append((onComplete, onError))
        if let error = stubbedHeroesError {
            _ = onError!(error)
        }
        if let success = stubbedHeroesSuccess {
            _ = onComplete!(success)
        }
    }
}
