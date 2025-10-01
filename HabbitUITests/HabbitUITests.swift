//
//  HabbitUITests.swift
//  HabbitUITests
//
//  Created by nat on 9/27/25.
//

import XCTest

final class HabbitUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }

    @MainActor
    func testAddHabitAndMarkDone() throws {
        let app = XCUIApplication()
        app.launch()

        // Add a habit
        let addButton = app.buttons["ContentView.AddHabitButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 3))
        addButton.tap()

        let nameField = app.textFields.firstMatch
        XCTAssertTrue(nameField.waitForExistence(timeout: 3))
        nameField.tap()
        nameField.typeText("Water 🌱")

        let saveButton = app.buttons["AddHabitView.SaveButton"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 3))
        saveButton.tap()

        // Verify the habit appears in the list
        let cell = app.cells.containing(.staticText, identifier: "Water 🌱").element
        XCTAssertTrue(cell.waitForExistence(timeout: 3))

        // Mark as done
        let doneButton = cell.buttons["HabitRowView.DoneButton"]
        XCTAssertTrue(doneButton.waitForExistence(timeout: 3))
        doneButton.tap()

        // Button should become disabled after marking done today
        XCTAssertFalse(doneButton.isEnabled)
    }
}
