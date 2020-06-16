//
//  HeroDetailViewTest.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 15/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import XCTest
import CoreData
@testable import DotaHeroes

class HeroDetailViewTest: XCTestCase {
    var mockCoreDataManager: DatabaseManager?
    var persistentContainer: NSPersistentContainer?
    var view: HeroDetailViewController?
    var mockEventHandler: MockHeroDetailEventHandler?
    var hero: HeroesData?

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
            
            self.hero = heroes!.first!

            view = HeroDetailViewController(hero: self.hero!)
            mockEventHandler = MockHeroDetailEventHandler()
            
            view?.presenter = mockEventHandler
            view?.loadView()
        } catch {
            XCTAssert(false, "Failed to initialize")
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoad() {
        view?.viewDidLoad()
        
        XCTAssert(mockEventHandler?.invokedGetSimilarHeroes == true, "Expected to be called")
        XCTAssert(mockEventHandler?.invokedGetSimilarHeroesCount == 1, "Expected to be called once")
    }
    
    func testBackButtonDidClicked() {
        view?.backButtonDidClicked(self)
        
        XCTAssert(mockEventHandler?.invokedPopHeroDetailView == true, "Expected to be called")
        XCTAssert(mockEventHandler?.invokedPopHeroDetailViewCount == 1, "Expected to be called once")
    }

    func testDidSelectHero() {
        view?.didSelectHero(withHero: hero!, indexPath: IndexPath(row: 0, section: 0))
        
        XCTAssert(mockEventHandler?.invokedShowHeroDetail == true, "Expected to be called")
        XCTAssert(mockEventHandler?.invokedShowHeroDetailCount == 1, "Expected to be called once")
    }
}
