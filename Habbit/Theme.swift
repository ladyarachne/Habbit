//
//  Theme.swift
//  Habbit
//
//  Created by nat on 9/27/25.
//

import SwiftUI

enum Theme {
    static let accent = Color(red: 1.0, green: 0.2, blue: 0.6) // pink accent
    static let softPink = Color(red: 1.0, green: 0.85, blue: 0.92)
    static let background = Color.white
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary

    static var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [softPink.opacity(0.35), background],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
