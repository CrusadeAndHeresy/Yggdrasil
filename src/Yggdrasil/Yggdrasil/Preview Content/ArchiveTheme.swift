import SwiftUI

struct ParchmentBackground: View {
    var body: some View {
        ZStack {
            // 1. The Core Paper Tone (Muted Gold/Tan)
            Color(red: 0.82, green: 0.76, blue: 0.65)
            
            // 2. The Deep Edge Decay (The Vignette)
            // This creates the darkening towards the edges you requested
            RadialGradient(
                stops: [
                    .init(color: .clear, location: 0.4),
                    .init(color: .black.opacity(0.3), location: 0.85),
                    .init(color: .black.opacity(0.6), location: 1.0)
                ],
                center: .center,
                startRadius: 100,
                endRadius: 500
            )
            
            // 3. Foxing & Staining (Simulated Age Spots)
            Canvas { context, size in
                for _ in 0...15 {
                    let rect = CGRect(
                        x: Double.random(in: 0...size.width),
                        y: Double.random(in: 0...size.height),
                        width: Double.random(in: 40...180),
                        height: Double.random(in: 30...120)
                    )
                    context.fill(Path(ellipseIn: rect), with: .color(.black.opacity(0.04)))
                    context.addFilter(.blur(radius: 30))
                }
            }
            
            // 4. Subtle Ink Spatter Texture
            Rectangle()
                .fill(.black.opacity(0.05))
                .mask(
                    Canvas { context, size in
                        for _ in 0...1000 {
                            let x = Double.random(in: 0...size.width)
                            let y = Double.random(in: 0...size.height)
                            context.fill(Path(ellipseIn: CGRect(x: x, y: y, width: 0.5, height: 0.5)), with: .color(.black))
                        }
                    }
                )
        }
        .ignoresSafeArea()
    }
}

extension Color {
    static let heresyRed = Color(red: 0.5, green: 0.0, blue: 0.0) // Deep, dried-blood red
}
