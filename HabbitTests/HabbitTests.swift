//
//  HabbitTests.swift
//  HabbitTests
//
//  Created by nat on 9/27/25.
//

import XCTest
@testable import Habbit

final class HabbitTests: XCTestCase {

    func testFirstCompletionStartsStreakAtOne() {
        let today = Calendar.current.startOfDay(for: Date())
        let result = StreakLogic.updatedStreak(currentStreak: 0, lastCompletion: nil, completingOn: today)
        XCTAssertEqual(result.streak, 1)
        XCTAssertEqual(Calendar.current.isDateInToday(result.newLastCompletion), true)
    }

    func testCompletingAgainSameDayDoesNotIncrement() {
        let today = Calendar.current.startOfDay(for: Date())
        let result1 = StreakLogic.updatedStreak(currentStreak: 1, lastCompletion: today, completingOn: today)
        XCTAssertEqual(result1.streak, 1)
    }

    func testCompletingAfterYesterdayIncrements() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let yesterday = cal.date(byAdding: .day, value: -1, to: today)!
        let result = StreakLogic.updatedStreak(currentStreak: 3, lastCompletion: yesterday, completingOn: today, calendar: cal)
        XCTAssertEqual(result.streak, 4)
    }

    func testMissingADayResetsToOne() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let twoDaysAgo = cal.date(byAdding: .day, value: -2, to: today)!
        let result = StreakLogic.updatedStreak(currentStreak: 5, lastCompletion: twoDaysAgo, completingOn: today, calendar: cal)
        XCTAssertEqual(result.streak, 1)
    }
}
