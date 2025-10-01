//
//  Habit.swift
//  Habbit
//
//  Created by nat on 9/27/25.
//

import Foundation
import SwiftData

@Model
final class Habit {
    @Attribute(.unique) var id: UUID
    var name: String
    var reminderHour: Int
    var reminderMinute: Int
    var streak: Int
    var lastCompletionDate: Date?
    var createdAt: Date

    init(id: UUID = UUID(), name: String, reminderHour: Int, reminderMinute: Int, streak: Int = 0, lastCompletionDate: Date? = nil, createdAt: Date = .now) {
        self.id = id
        self.name = name
        self.reminderHour = reminderHour
        self.reminderMinute = reminderMinute
        self.streak = streak
        self.lastCompletionDate = lastCompletionDate
        self.createdAt = createdAt
    }

    var reminderDateComponents: DateComponents {
        var comps = DateComponents()
        comps.hour = reminderHour
        comps.minute = reminderMinute
        return comps
    }

    var completedToday: Bool {
        guard let last = lastCompletionDate else { return false }
        return Calendar.current.isDateInToday(last)
    }

    func markDone(on date: Date = .now, calendar: Calendar = .current) {
        let result = StreakLogic.updatedStreak(currentStreak: streak, lastCompletion: lastCompletionDate, completingOn: date, calendar: calendar)
        self.streak = result.streak
        self.lastCompletionDate = result.newLastCompletion
    }
}
