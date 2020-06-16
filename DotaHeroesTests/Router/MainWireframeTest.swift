//
//  MainWireframeTest.swift
//  DotaHeroesTests
//
//  Created by Benedict Lukas on 16/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import XCTest
@testable import DotaHeroes

class MainWireframeTest: XCTestCase {
    var mainWireframe: MainWireframe?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mainWireframe = MainWireframe()
        _ = mainWireframe?.viewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWireframe() {
        let navController = mainWireframe!.viewController as? UINavigationController
        let mainController = navController?.viewControllers.first as? MainViewController

        XCTAssert(navController != nil, "Expected to be a UINavigationController")
        XCTAssert(mainController != nil, "Expected to be Main View Controller")
    }

}
