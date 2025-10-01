//
//  HabitRowView.swift
//  Habbit
//
//  Created by nat on 9/27/25.
//

import SwiftUI

struct HabitRowView: View {
    let habit: Habit
    let onDone: () -> Void
    
    private var done: Bool { habit.completedToday }

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(habit.name)
                    .font(.headline)
                HStack(spacing: 8) {
                    Image(systemName: "flame.fill")
                        .foregroundStyle(habit.streak > 0 ? .orange : .secondary)
                    Text("\(habit.streak)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    if let last = habit.lastCompletionDate {
                        Text(last, style: .date)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            Spacer()
            Button(action: onDone) {
                Text(done ? "Done ✅" : "Done")
                    .fontWeight(.semibold)
                    .foregroundStyle(done ? Theme.accent : Color.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        Capsule().fill(done ? Theme.accent.opacity(0.15) : Theme.accent)
                    )
            }
            .buttonStyle(.plain)
            .disabled(done)
            .accessibilityIdentifier("HabitRowView.DoneButton")
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

#Preview {
    HabitRowView(
        habit: Habit(name: "Vitamins 💊", reminderHour: 9, reminderMinute: 0, streak: 3, lastCompletionDate: .now),
        onDone: {}
    )
    .padding()
    .background(Theme.softPink.opacity(0.2))
}
