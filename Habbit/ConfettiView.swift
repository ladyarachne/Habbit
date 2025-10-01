//
//  ConfettiView.swift
//  Habbit
//
//  Created by nat on 9/27/25.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

struct ConfettiView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear

        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: -10)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 1)

        // Refined, cute shapes and colors
        let symbols: [(name: String, color: UIColor)] = [
            ("heart.fill", .systemPink),
            ("star.fill", UIColor(red: 1.0, green: 0.85, blue: 0.92, alpha: 1.0)), // soft pink
            ("hare.fill", .systemPink), // rabbit
            ("leaf.fill", UIColor.systemGreen), // sprout 🌱
            ("pills.fill", UIColor.systemTeal), // pill 💊
            ("bell.fill", UIColor.systemYellow), // reminder 🔔
            ("flame.fill", UIColor.systemOrange) // streak 🔥
        ]

        func cell(symbol: String, tint: UIColor) -> CAEmitterCell {
            let cell = CAEmitterCell()
            cell.birthRate = 6
            cell.lifetime = 6.0
            cell.velocity = 180
            cell.velocityRange = 80
            cell.emissionLongitude = .pi
            cell.emissionRange = .pi / 4
            cell.spin = 3.5
            cell.spinRange = 1.2
            cell.scale = 0.6
            cell.scaleRange = 0.3
            cell.color = tint.cgColor
            let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
            cell.contents = UIImage(systemName: symbol)?.withConfiguration(config).withTintColor(tint, renderingMode: .alwaysOriginal).cgImage
            return cell
        }

        emitter.emitterCells = symbols.flatMap { pair in
            // Create a couple variants per symbol for visual richness
            [cell(symbol: pair.name, tint: pair.color), cell(symbol: pair.name, tint: pair.color.withAlphaComponent(0.85))]
        }

        view.layer.addSublayer(emitter)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            emitter.birthRate = 0
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

#else

// Fallback for platforms without UIKit (e.g., macOS previews)
struct ConfettiView: View {
    var body: some View { Color.clear }
}

#endif
