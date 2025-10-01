//
//  HabitsViewModel.swift
//  Habbit
//
//  Created by nat on 9/27/25.
//

import Foundation
import SwiftData
import UserNotifications
import Combine

@MainActor
final class HabitsViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    private let notificationManager: NotificationManager
    private let milestoneSet: Set<Int> = [1, 3, 7, 14, 21, 30, 50, 100]

    init(notificationManager: NotificationManager) {
        self.notificationManager = notificationManager
    }

    func addHabit(name: String, time: DateComponents, context: ModelContext) {
        let hour = time.hour ?? 9
        let minute = time.minute ?? 0
        let habit = Habit(name: name, reminderHour: hour, reminderMinute: minute)
        context.insert(habit)
        scheduleNotification(for: habit)
    }

    func deleteHabit(habit: Habit, context: ModelContext) {
        notificationManager.cancelNotification(for: habit)
        context.delete(habit)
    }

    func markDone(habit: Habit, context: ModelContext) {
        guard !habit.completedToday else { return }
        habit.markDone()
    }

    /// Marks done and returns true if a milestone streak was reached
    func markDoneAndCheckMilestone(habit: Habit, context: ModelContext) -> Bool {
        let previous = habit.streak
        markDone(habit: habit, context: context)
        let hit = habit.streak != previous && milestoneSet.contains(habit.streak)
        return hit
    }

    func scheduleNotification(for habit: Habit) {
        notificationManager.scheduleDailyReminder(for: habit)
    }

    func ensureNotificationAuthorization() async {
        await notificationManager.requestAuthorizationIfNeeded()
    }
}

