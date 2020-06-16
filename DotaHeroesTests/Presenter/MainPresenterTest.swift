//
//  MainPresenterTest.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 15/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import XCTest
import CoreData
@testable import DotaHeroes

class MainPresenterTest: XCTestCase {
    var presenter: MainPresenter?
    var mockView: MockMainView?
    var mockInteractorInput: MockMainInput?
    var mockWireframe: MockMainWireframe?
    var mockCoreDataManager: DatabaseManager?
    var persistentContainer: NSPersistentContainer?
    var heroes: [HeroesData]?
    var roles: [RolesData]?

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
            self.heroes = heroes
            self.roles = roles
        } catch {
            XCTAssert(false, "Failed to initialize")
        }
        
        mockView = MockMainView()
        mockInteractorInput = MockMainInput()
        mockWireframe = MockMainWireframe()

        presenter = MainPresenter(interactor: mockInteractorInput!, router: mockWireframe!, view: mockView!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetHeroesAndRoles() {
        presenter?.getHeroesAndRoles()
        
        XCTAssert(mockInteractorInput?.invokedGetHeroesAndRoles == true, "Expected to be called")
        XCTAssert(mockInteractorInput?.invokedGetHeroesAndRolesCount == 1, "Expected to be called once")
    }

    func testGetFilteredHeroes() {
        let role = roles!.first!
        presenter?.getFilteredHeroes(withRole: role)
        
        XCTAssert(mockInteractorInput?.invokedGetFilteredHeroes == true, "Expected to be called")
        XCTAssert(mockInteractorInput?.invokedGetFilteredHeroesCount == 1, "Expected to be called once")
    }

    func testShowHeroesAndRoles() {
        presenter?.showHeroesAndRoles(heroes: heroes!, roles: roles!)
        
        XCTAssert(mockView?.invokedShowHeroesAndRoles == true, "Expected to be called")
        XCTAssert(mockView?.invokedShowHeroesAndRolesCount == 1, "Expected to be called once")
    }

    func testShowFilteredHeroes() {
        presenter?.showFilteredHeroes(heroes: heroes!)
        
        XCTAssert(mockView?.invokedShowFilteredHeroes == true, "Expected to be called")
        XCTAssert(mockView?.invokedShowFilteredHeroesCount == 1, "Expected to be called once")
    }

    func testShowError() {
        presenter?.showError()
        
        XCTAssert(mockView?.invokedShowError == true, "Expected to be called")
        XCTAssert(mockView?.invokedShowErrorCount == 1, "Expected to be called once")
    }

}
