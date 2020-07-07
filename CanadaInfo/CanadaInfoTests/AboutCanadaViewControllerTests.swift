//
//  CanadaInfoTests.swift
//  CanadaInfoTests
//
//  Created by Vivek John on 01/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import XCTest
@testable import CanadaInfo

class AboutCanadaViewControllerTests: XCTestCase {
    
    var sut: AboutCanadaViewController!
    var viewModel = AboutCanadaViewModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "AboutCanada", bundle: nil)
        if let aboutCanadaVC = storyboard.instantiateViewController(withIdentifier:
            "AboutCanadaViewController") as? AboutCanadaViewController {
            sut = aboutCanadaVC
            let view = aboutCanadaVC.view
            sut.beginAppearanceTransition(true, animated: true)
            sut.endAppearanceTransition()
            XCTAssertNotEqual(aboutCanadaVC.viewModel.rowModel?.count, 0, "Array contain value")
            XCTAssertNotNil(view,
                            "View should not be nil")
            XCTAssertNotNil(aboutCanadaVC,
                            "VisualSearchViewController should not be nil")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func testInitialScreenUI() {
        let aboutCanadaVC = sut
        XCTAssertEqual(aboutCanadaVC?.lblTitle.text, "No Data", "Title label initially contain no data")
        XCTAssertNotNil(aboutCanadaVC?.refreshControl,
                        "refreshControl should not be nil")
    }
    
    func testThatTableViewHasDataSource() {
        XCTAssertNotNil(sut.tableViewList.dataSource, "Table datasource cannot be nil")
    }
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(sut.tableViewList.delegate, "Table delegate cannot be nil")
    }
    
    func testTableViewNumberOfSection() {
        XCTAssertTrue(sut.tableViewList.numberOfRows(inSection: 0) == sut.viewModel.rowModel?.count ?? 0)
    }
    
    func testUpdateUI() {
        let aboutCanadaModel = AboutCanadaViewModel()
        sut.viewModel = aboutCanadaModel
        sut.updateUI()
    }
    
    func testTableViewCellCreateCellsWithReuseIdentifier() {
        let indexpath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableViewList, cellForRowAt: indexpath)
        XCTAssertTrue(cell.reuseIdentifier == "AboutListTableViewCell")
    }
}
