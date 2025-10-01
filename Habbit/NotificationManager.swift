//
//  NotificationManager.swift
//  Habbit
//
//  Created by nat on 9/27/25.
//

import Foundation
import UserNotifications

final class NotificationManager {
    private let center = UNUserNotificationCenter.current()

    func requestAuthorizationIfNeeded() async {
        let settings = await center.notificationSettings()
        switch settings.authorizationStatus {
        case .notDetermined:
            do {
                try await center.requestAuthorization(options: [.alert, .sound, .badge])
            } catch {
                print("Notification authorization error: \(error)")
            }
        default:
            break
        }
    }

    func scheduleDailyReminder(for habit: Habit) {
        let content = UNMutableNotificationContent()
        content.title = "Habbit Reminder 🐇"
        content.body = "\(habit.name) — it's time!"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = habit.reminderHour
        dateComponents.minute = habit.reminderMinute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: notificationIdentifier(for: habit), content: content, trigger: trigger)
        center.add(request) { error in
            if let error = error { print("Failed to schedule notification: \(error)") }
        }
    }

    func cancelNotification(for habit: Habit) {
        center.removePendingNotificationRequests(withIdentifiers: [notificationIdentifier(for: habit)])
    }

    private func notificationIdentifier(for habit: Habit) -> String {
        return "habit-\(habit.id.uuidString)"
    }
}
