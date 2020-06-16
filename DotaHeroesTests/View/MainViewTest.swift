//
//  MainViewTest.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 15/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import XCTest
import CoreData
@testable import DotaHeroes

class MainViewTest: XCTestCase {
    var mockCoreDataManager: DatabaseManager?
    var persistentContainer: NSPersistentContainer?
    var view: MainViewController?
    var mockEventHandler: MockMainEventHandler?
    var hero: HeroesData?
    var role: RolesData?

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

            let heroesSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            let rolesSortDescriptor = NSSortDescriptor(key: "role", ascending: true)
            let heroes = self.mockCoreDataManager?.fetch(ofType: HeroesData.self, sortDescriptors: [heroesSortDescriptor])
            let roles = self.mockCoreDataManager?.fetch(ofType: RolesData.self, sortDescriptors: [rolesSortDescriptor])
            
            self.hero = heroes!.first!
            self.role = roles?.first
        } catch {
            XCTAssert(false, "Failed to initialize")
        }

        view = MainViewController()
        mockEventHandler = MockMainEventHandler()
        
        view?.presenter = mockEventHandler
        view?.loadView()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewDidLoad() {
        view?.viewDidLoad()
        
        XCTAssert(mockEventHandler?.invokedGetHeroesAndRoles == true, "Expected to be called")
        XCTAssert(mockEventHandler?.invokedGetHeroesAndRolesCount == 1, "Expected to be called once")
    }
    
    func testTryAgainDidClicked() {
        view?.tryAgainDidClicked(self)
        
        XCTAssert(mockEventHandler?.invokedGetHeroesAndRoles == true, "Expected to be called")
        XCTAssert(mockEventHandler?.invokedGetHeroesAndRolesCount == 1, "Expected to be called once")
    }

    func testDidSelectRole() {
        view?.didSelectRole(withRole: role!, indexPath: IndexPath(row: 0, section: 0))
        
        XCTAssert(mockEventHandler?.invokedGetFilteredHeroes == true, "Expected to be called")
        XCTAssert(mockEventHandler?.invokedGetFilteredHeroesCount == 1, "Expected to be called once")
    }

    func testDidSelectHero() {
        view?.didSelectHero(withHero: hero!, indexPath: IndexPath(row: 0, section: 0))
        
        XCTAssert(mockEventHandler?.invokedShowHeroDetail == true, "Expected to be called")
        XCTAssert(mockEventHandler?.invokedShowHeroDetailCount == 1, "Expected to be called once")
    }
}
