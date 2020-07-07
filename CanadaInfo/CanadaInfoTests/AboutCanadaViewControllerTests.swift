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
        
        if let keyWindow = UIWindow.key {
            keyWindow.rootViewController = sut
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
        let titleOne = "TitleOne"
        let descOne = "DescOne"
        var row = Row()
        row.desc = descOne
        row.title = titleOne
        if let aboutCell = cell as? AboutListTableViewCell {
            aboutCell.configure(item: row)
            XCTAssertEqual(aboutCell.lblTitle.text, titleOne, "Title text should match")
            XCTAssertEqual(aboutCell.lblDescription.text, descOne, "Title text should match")
            XCTAssertEqual(aboutCell.imageView?.image, nil, "No image to display")
        }
    }
    
    func testAlert() {
        Alert.present(title: Alert.Network.title,
        message: "Error Message",
        actions: .close,
            from: sut)
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
        XCTAssertEqual(sut.presentedViewController?.title, "Network Error")
        let alertController = sut.presentedViewController as? UIAlertController
        let action = alertController?.actions[0]
        XCTAssertEqual(action?.title, "Ok")
    }
}
