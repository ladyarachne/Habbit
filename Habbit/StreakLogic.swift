//
//  StreakLogic.swift
//  Habbit
//
//  Created by nat on 9/27/25.
//

import Foundation

struct StreakLogic {
    /// Returns the updated streak and last completion date after marking a habit done on `completingOn`.
    /// Rules:
    /// - If already completed today → ignore (streak unchanged)
    /// - If completed yesterday → increment streak
    /// - If missed a day (or first time) → reset to 1
    static func updatedStreak(
        currentStreak: Int,
        lastCompletion: Date?,
        completingOn: Date,
        calendar: Calendar = .current
    ) -> (streak: Int, newLastCompletion: Date) {
        // Normalize dates to day granularity
        if let last = lastCompletion {
            if calendar.isDate(last, inSameDayAs: completingOn) {
                // Already done today; ignore
                return (currentStreak, last)
            }
            if let yesterday = calendar.date(byAdding: .day, value: -1, to: completingOn), calendar.isDate(last, inSameDayAs: yesterday) {
                return (max(0, currentStreak) + 1, completingOn)
            }
            // Missed at least one day
            return (1, completingOn)
        } else {
            // First completion ever
            return (1, completingOn)
        }
    }
}
