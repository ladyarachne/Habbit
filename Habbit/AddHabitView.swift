//
//  AddHabitView.swift
//  Habbit
//
//  Created by nat on 9/27/25.
//

import SwiftUI

struct AddHabitView: View {
    var onSave: (String, DateComponents) -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var time: Date = Date()

    var body: some View {
        NavigationStack {
            Form {
                Section("Habit") {
                    TextField("Name (e.g. Vitamins 💊)", text: $name)
                }
                Section("Reminder time") {
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                }
            }
            .navigationTitle("New Habit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let comps = Calendar.current.dateComponents([.hour, .minute], from: time)
                        onSave(name, comps)
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .accessibilityIdentifier("AddHabitView.SaveButton")
                }
            }
        }
    }
}

#Preview {
    AddHabitView { _, _ in }
}
