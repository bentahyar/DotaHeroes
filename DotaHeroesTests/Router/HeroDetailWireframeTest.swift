//
//  HeroDetailWireframeTest.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 16/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import XCTest
import CoreData
@testable import DotaHeroes

class HeroDetailWireframeTest: XCTestCase {
    var heroWireframe: HeroDetailWireframe?
    var mockCoreDataManager: DatabaseManager?
    var persistentContainer: NSPersistentContainer?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        persistentContainer = MockPersistentContainer().container
        mockCoreDataManager = DatabaseManager(persistentContainer: persistentContainer!)

        guard let file = Bundle.main.url(forResource: "Heroes", withExtension: "json") else {
            XCTAssert(false, "Heroes.json is missing")
            return
        }
        
        do {
            let data = try Data(contentsOf: file)
            mockCoreDataManager?.insert(data: data)

            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            let heroes = mockCoreDataManager?.fetch(ofType: HeroesData.self, sortDescriptors: [sortDescriptor])

            heroWireframe = HeroDetailWireframe(hero: heroes!.first!)
            _ = heroWireframe?.viewController
        } catch {
            XCTAssert(false, "Failed to initialize")
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWireframe() {
        let heroController = heroWireframe!.viewController as? HeroDetailViewController

        XCTAssert(heroController != nil, "Expected to be Hero Detail Controller")
    }

}
