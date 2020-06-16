//
//  HeroDetailPresenterTest.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 15/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import XCTest
import CoreData
@testable import DotaHeroes

class HeroDetailPresenterTest: XCTestCase {
    var presenter: HeroDetailPresenter?
    var mockView: MockHeroDetailView?
    var mockInteractorInput: MockHeroDetailInput?
    var mockWireframe: MockHeroDetailWireframe?
    var mockCoreDataManager: DatabaseManager?
    var persistentContainer: NSPersistentContainer?
    var heroes: [HeroesData]?

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
            self.heroes = heroes
            
            let hero = heroes!.first!

            mockView = MockHeroDetailView()
            mockInteractorInput = MockHeroDetailInput()
            mockWireframe = MockHeroDetailWireframe(hero: hero)

            presenter = HeroDetailPresenter(interactor: mockInteractorInput!, router: mockWireframe!, view: mockView!)
        } catch {
            XCTAssert(false, "Failed to initialize")
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetSimilarHeroes() {
        let hero = heroes!.first!
        presenter?.getSimilarHeroes(withHero: hero)
        
        XCTAssert(mockInteractorInput?.invokedGetSimilarHeroes == true, "Expected to be called")
        XCTAssert(mockInteractorInput?.invokedGetSimilarHeroesCount == 1, "Expected to be called once")
    }

    func testShowSimilarHeroes() {
        presenter?.showSimilarHeroes(heroes: heroes!)
        
        XCTAssert(mockView?.invokedShowSimilarHeroes == true, "Expected to be called")
        XCTAssert(mockView?.invokedShowSimilarHeroesCount == 1, "Expected to be called once")
    }

}
