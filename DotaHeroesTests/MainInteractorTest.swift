//
//  MainInteractorTest.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import XCTest
import CoreData
import Alamofire
@testable import DotaHeroes

class MainInteractorTest: XCTestCase {
    var interactor: MainInteractor?
    var mockOutput: MockMainOutput?
    var mockService: MockHeroesService?
    var mockCoreDataManager: DatabaseManager?
    var persistentContainer: NSPersistentContainer?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        persistentContainer = MockPersistentContainer().container
        mockCoreDataManager = DatabaseManager(persistentContainer: persistentContainer!)
        mockOutput = MockMainOutput()
        mockService = MockHeroesService()
        interactor = MainInteractor(service: mockService!,
                                    databaseManager: mockCoreDataManager!)

        interactor?.output = mockOutput
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetHeroesAndRolesWhenSuccess() throws {
        guard let file = Bundle.main.url(forResource: "Heroes", withExtension: "json") else {
            XCTAssert(false, "Heroes.json is missing")
            return
        }
        
        let data = try Data(contentsOf: file)
        mockService?.stubbedHeroesSuccess = data
        
        interactor?.getHeroesAndRoles()
        
        XCTAssert(mockOutput?.invokedShowHeroesAndRoles == true, "Expected to be called")
        XCTAssert(mockOutput?.invokedShowError == false, "Expected not to be called")
        
        let heroes = mockCoreDataManager?.fetch(ofType: HeroesData.self)
        let roles = mockCoreDataManager?.fetch(ofType: RolesData.self)
        XCTAssert(heroes?.count == 5, "Expected to have 5 data")
        XCTAssert(roles?.count == 9, "Expected number of roles is 9")
        
        XCTAssert(mockOutput?.invokedShowHeroesAndRolesParameters?.heroes.count == 5, "Expected to have 5 items")
        XCTAssert(mockOutput?.invokedShowHeroesAndRolesParameters?.roles.count == 9, "Expected to have 9 items")
    }
    
    func testGetHeroesAndRolesIfLocalExist() throws {
        guard let file = Bundle.main.url(forResource: "Heroes", withExtension: "json") else {
            XCTAssert(false, "Heroes.json is missing")
            return
        }
        
        let data = try Data(contentsOf: file)
        mockService?.stubbedHeroesSuccess = data
        mockCoreDataManager?.insert(data: data)
        
        interactor?.getHeroesAndRoles()
        
        XCTAssert(mockOutput?.invokedShowHeroesAndRoles == true, "Expected to be called")
        XCTAssert(mockOutput?.invokedShowError == false, "Expected not to be called")
        
        let heroes = mockCoreDataManager?.fetch(ofType: HeroesData.self)
        let roles = mockCoreDataManager?.fetch(ofType: RolesData.self)
        XCTAssert(heroes?.count == 5, "Expected to have 5 data")
        XCTAssert(roles?.count == 9, "Expected number of roles is 9")
        
        XCTAssert(mockService?.invokedHeroes == false, "Expected not to be called")
    }
    
    func testGetHeroesAndRolesWhenFailed() {
        let error = NSError()
        mockService?.stubbedHeroesError = error
        
        interactor?.getHeroesAndRoles()
        
        XCTAssert(mockOutput?.invokedShowHeroesAndRoles == false, "Expected not to be called")
        XCTAssert(mockOutput?.invokedShowError == true, "Expected to be called")
    }
    
    func testGetFilteredHeroesByCarry() throws {
        guard let file = Bundle.main.url(forResource: "Heroes", withExtension: "json") else {
            XCTAssert(false, "Heroes.json is missing")
            return
        }
        
        let data = try Data(contentsOf: file)
        mockCoreDataManager?.insert(data: data)

        let entity =  NSEntityDescription.entity(forEntityName: RolesData.entityName(), in: persistentContainer!.viewContext)!
        let roleData = RolesData(entity: entity, insertInto: persistentContainer?.viewContext)
        roleData.role = "Carry"
        mockCoreDataManager?.saveContext()
        
        interactor?.getFilteredHeroes(withRole: roleData)
        
        XCTAssert(mockOutput?.invokedShowFilteredHeroes == true, "Expected to be called")
        XCTAssert(mockOutput?.invokedShowError == false, "Expected not to be called")
        XCTAssert(mockOutput?.invokedShowFilteredHeroesParameters?.heroes.count == 2, "Expected to have 5 items")
    }
    
    func testGetFilteredHeroesByAll() throws {
        guard let file = Bundle.main.url(forResource: "Heroes", withExtension: "json") else {
            XCTAssert(false, "Heroes.json is missing")
            return
        }
        
        let data = try Data(contentsOf: file)
        mockCoreDataManager?.insert(data: data)

        let entity =  NSEntityDescription.entity(forEntityName: RolesData.entityName(), in: persistentContainer!.viewContext)!
        let roleData = RolesData(entity: entity, insertInto: persistentContainer?.viewContext)
        roleData.role = "All"
        mockCoreDataManager?.saveContext()
        
        interactor?.getFilteredHeroes(withRole: roleData)
        
        XCTAssert(mockOutput?.invokedShowFilteredHeroes == true, "Expected to be called")
        XCTAssert(mockOutput?.invokedShowError == false, "Expected not to be called")
        XCTAssert(mockOutput?.invokedShowFilteredHeroesParameters?.heroes.count == 5, "Expected to have 5 items")
    }
}
