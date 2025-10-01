//
//  ContentView.swift
//  Habbit
//
//  Created by nat on 9/27/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Habit.createdAt, order: .forward)]) private var habits: [Habit]

    @State private var showingAddHabit = false
    @StateObject private var viewModel = HabitsViewModel(notificationManager: NotificationManager())
    @State private var showConfetti = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.backgroundGradient.ignoresSafeArea()
                Group {
                    if habits.isEmpty {
                        VStack(spacing: 16) {
                            Text("🐇")
                                .font(.system(size: 56))
                            Text("No habits yet")
                                .font(.title3)
                                .foregroundStyle(Theme.textSecondary)
                            Text("Tap the + to add your first habit")
                                .foregroundStyle(Theme.textSecondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Theme.softPink.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding()
                    } else {
                        List {
                            ForEach(habits) { habit in
                                HabitRowView(habit: habit) {
                                    let milestoneHit = viewModel.markDoneAndCheckMilestone(habit: habit, context: modelContext)
                                    if milestoneHit { withAnimation { showConfetti = true } }
                                }
                                .listRowBackground(Theme.softPink.opacity(0.08))
                            }
                            .onDelete { indexSet in
                                for index in indexSet { viewModel.deleteHabit(habit: habits[index], context: modelContext) }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(.clear)
#if os(iOS)
                        .listStyle(.insetGrouped)
#else
                        .listStyle(.inset)
#endif
                    }
                }
                if showConfetti {
                    ConfettiView()
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation { showConfetti = false }
                            }
                        }
                }
            }
            .navigationTitle("Habbit 🐇")
#if os(iOS)
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(Theme.softPink.opacity(0.2), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Label("Add Habit", systemImage: "plus")
                    }
                    .tint(Theme.accent)
                    .accessibilityIdentifier("ContentView.AddHabitButton")
                }
#else
                ToolbarItem(placement: .automatic) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Label("Add Habit", systemImage: "plus")
                    }
                    .accessibilityIdentifier("ContentView.AddHabitButton")
                }
#endif
            }
        }
        .tint(Theme.accent)
        .sheet(isPresented: $showingAddHabit) {
            AddHabitView { name, components in
                viewModel.addHabit(name: name, time: components, context: modelContext)
                showingAddHabit = false
            }
        }
        .task {
            // Skip system prompts during tests
            let isTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
            if !isTesting {
                await viewModel.ensureNotificationAuthorization()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self, inMemory: true)
}
