# Habbit 🐇

A cute, streak-based habit tracker for daily routines or medications. Cozy pink-and-white theme with playful vibes.

## Features
- Add habits with a reminder time
- Home screen list of habits with name, 🔥 streak, and a “Done” button
- Streak logic:
  - If completed yesterday → increment streak
  - If already done today → ignore
  - If a day is missed → reset streak to 1
- Local notifications for reminders (UNUserNotificationCenter)
- Persistence with SwiftData (iOS 17+)
- Confetti on milestone streaks (1, 3, 7, 14, 21, 30, 50, 100)

## Requirements
- Xcode 15+ (or Xcode 26.x)
- iOS 17.0+ (SwiftData)

## Project structure
- Models: Habit.swift (defined in Item.swift)
- ViewModels: HabitsViewModel.swift
- Views: ContentView.swift, AddHabitView.swift, HabitRowView.swift
- Logic helpers: StreakLogic.swift, NotificationManager.swift, Theme.swift, ConfettiView.swift
- Tests: HabbitTests.swift (streak logic), HabbitUITests.swift

