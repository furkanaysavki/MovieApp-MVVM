//
//  MovieAppUITest.swift
//  MovieAppUITest
//
//  Created by Furkan Ayşavkı on 23.10.2022.
//

import XCTest
import SwiftUI

class MovieAppUITests: XCTestCase {

    func testMovieApp() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let todetailNavigationBar = app.navigationBars["MovieApp.HomeView"]
        let searchSearchField = todetailNavigationBar.searchFields["Search"]
        let searchField = searchSearchField
        let cell = app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Batman Begins").element
        let searchClick = app.buttons["Search"]
        let back = app.navigationBars["MovieApp.DetailView"].buttons["Back"]
        let clear = searchSearchField.buttons["Clear text"]
        let OK = app.alerts["ERROR"].scrollViews.otherElements.buttons["OK"]
       
        searchField.tap()
        searchField.typeText("batman")
        searchClick.tap()
        cell.tap()
        back.tap()
        clear.tap()
        searchField.typeText("asdf")
        searchClick.tap()
        OK.tap()
     
                
        XCTAssertTrue(cell.exists)
        XCTAssertEqual(app.alerts.element.label, "ERROR")
        
    
        
        
        
       
               
        
       
               
                
        
        
                                
       
    }

}
