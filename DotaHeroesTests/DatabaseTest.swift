//
//  DatabaseTest.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import XCTest
import CoreData
@testable import DotaHeroes

class DotaHeroesTests: XCTestCase {
    var mockCoreDataManager: DatabaseManager?
    var persistentContainer: NSPersistentContainer?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        persistentContainer = MockPersistentContainer().container
        mockCoreDataManager = DatabaseManager(persistentContainer: persistentContainer!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockCoreDataManager = nil
    }

    func testInsertAndGetHeroesData() throws {
        guard let file = Bundle.main.url(forResource: "Heroes", withExtension: "json") else {
            XCTAssert(false, "Heroes.json is missing")
            return
        }
        
        let data = try Data(contentsOf: file)
        mockCoreDataManager?.insert(data: data)

        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let heroes = mockCoreDataManager?.fetch(ofType: HeroesData.self, sortDescriptors: [sortDescriptor])
        
        XCTAssert(heroes?.count == 5, "Expected to have 5 data")
        
        guard let hero = heroes?.first else {
            XCTAssert(false, "First hero should not be nill")
            return
        }
        
        XCTAssert(hero.heroId == 1, "id of first hero should be 1")
        XCTAssert(hero.name == "Anti-Mage", "name of first hero should be Anti Mage")
        XCTAssert(hero.image == "/apps/dota2/images/heroes/antimage_full.png?", "image of first hero should be /apps/dota2/images/heroes/antimage_full.png?")
        XCTAssert(hero.attr == "agi", "attr of first hero should be agi")
        XCTAssert(hero.type == "Melee", "type of first hero should be Melee")
        XCTAssert(hero.health == 200, "health of first hero should be 200")
        XCTAssert(hero.attack == 33, "attack of first hero should be 33")
        XCTAssert(hero.speed == 310, "speed of first hero should be 310")
        
        XCTAssert(hero.roles.count == 3, "Should have 3 roles")
    }
    
    func testInsertAndGetRolesData() throws {
        guard let file = Bundle.main.url(forResource: "Heroes", withExtension: "json") else {
            XCTAssert(false, "Heroes.json is missing")
            return
        }
        
        let data = try Data(contentsOf: file)
        mockCoreDataManager?.insert(data: data)
        
        let roles = mockCoreDataManager?.fetch(ofType: RolesData.self)
        
        XCTAssert(roles?.count == 8, "Expected number of roles is 8")
    }

}
