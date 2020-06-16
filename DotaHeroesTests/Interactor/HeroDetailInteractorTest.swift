//
//  HeroDetailInteractorTest.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import XCTest
import CoreData
@testable import DotaHeroes

class HeroDetailInteractorTest: XCTestCase {
    var interactor: HeroDetailInteractor?
    var mockOutput: MockHeroDetailOutput?
    var mockCoreDataManager: DatabaseManager?
    var persistentContainer: NSPersistentContainer?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockOutput = MockHeroDetailOutput()
        persistentContainer = MockPersistentContainer().container
        mockCoreDataManager = DatabaseManager(persistentContainer: persistentContainer!)
        interactor = HeroDetailInteractor(databaseManager: mockCoreDataManager!)

        interactor?.output = mockOutput
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetSimilarHeroes() throws {
        guard let file = Bundle.main.url(forResource: "SimilarHeroes", withExtension: "json") else {
            XCTAssert(false, "SimilarHeroes.json is missing")
            return
        }
        
        let data = try Data(contentsOf: file)
        mockCoreDataManager?.insert(data: data)
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let heroes = mockCoreDataManager?.fetch(ofType: HeroesData.self, sortDescriptors: [sortDescriptor])
        
        guard let hero = heroes?.first else {
            XCTAssert(false, "First hero should not be nill")
            return
        }
        
        interactor?.getSimilarHeroes(withHero: hero)
        
        XCTAssert(mockOutput?.invokedShowSimilarHeroes == true, "Expected to be called")
        
        guard let similarHeroes = mockOutput?.invokedShowSimilarHeroesParameters?.heroes else {
            XCTAssert(mockOutput?.invokedShowSimilarHeroesParameters?.heroes.count == 3, "Expected to have 3 similar heroes")
            return
        }

        XCTAssert(similarHeroes.contains(where: { $0 == hero }) == false, "Expected not to have hero in similar heroes")
        
        let firstHero = similarHeroes[0]
        let secondHero = similarHeroes[1]
        let thirdHero = similarHeroes[2]

        XCTAssert(firstHero.heroId == 11, "id of first hero should be 11")
        XCTAssert(firstHero.name == "Shadow Fiend", "name of first hero should be Shadow Fiend")

        XCTAssert(secondHero.heroId == 8, "id of second hero should be 8")
        XCTAssert(secondHero.name == "Juggernaut", "name of second hero should be Juggernaut")
        
        XCTAssert(thirdHero.heroId == 4, "id of third hero should be 4")
        XCTAssert(thirdHero.name == "Bloodseeker", "name of third hero should be Bloodseeker")
    }
    
    func testGetSimilarHeroesIfSimilarHeroesIsLessThan3() throws {
        guard let file = Bundle.main.url(forResource: "SimilarHeroes2", withExtension: "json") else {
            XCTAssert(false, "SimilarHeroes2.json is missing")
            return
        }
        
        let data = try Data(contentsOf: file)
        mockCoreDataManager?.insert(data: data)
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let heroes = mockCoreDataManager?.fetch(ofType: HeroesData.self, sortDescriptors: [sortDescriptor])
        
        guard let hero = heroes?.first else {
            XCTAssert(false, "First hero should not be nill")
            return
        }
        
        interactor?.getSimilarHeroes(withHero: hero)
        
        XCTAssert(mockOutput?.invokedShowSimilarHeroes == true, "Expected to be called")
        
        guard let similarHeroes = mockOutput?.invokedShowSimilarHeroesParameters?.heroes else {
            XCTAssert(mockOutput?.invokedShowSimilarHeroesParameters?.heroes.count == 2, "Expected to have 2 similar heroes")
            return
        }

        XCTAssert(similarHeroes.contains(where: { $0 == hero }) == false, "Expected not to have hero in similar heroes")
        
        let firstHero = similarHeroes[0]
        let secondHero = similarHeroes[1]

        XCTAssert(firstHero.heroId == 4, "id of first hero should be 4")
        XCTAssert(firstHero.name == "Bloodseeker", "name of first hero should be Bloodseeker")

        XCTAssert(secondHero.heroId == 12, "id of second hero should be 12")
        XCTAssert(secondHero.name == "Phantom Lancer", "name of second hero should be Phantom Lancer")
    }

}
