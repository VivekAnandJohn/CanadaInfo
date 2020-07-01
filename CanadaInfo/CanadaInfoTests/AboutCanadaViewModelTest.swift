//
//  AboutCanadaViewModel.swift
//  CanadaInfoTests
//
//  Created by Vivek John on 01/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import XCTest
@testable import CanadaInfo

class AboutCanadaViewModelTests: XCTestCase {
    var viewModel: AboutCanadaViewModel?

    override func setUp() {
        super.setUp()
        viewModel = AboutCanadaViewModel()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testGetAboutCanadaDetails() {
        let getDataExpectation = self.expectation(description: "Get Data Expectation")
        viewModel?.getAboutCanadaDetails { error in
            if error != nil {
            }
            getDataExpectation.fulfill()
        }
        wait(for: [getDataExpectation], timeout: 10)
    }
}
