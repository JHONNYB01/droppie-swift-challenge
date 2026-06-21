//
//  CircleDetection.swift
//  Droppie — Swift Student Challenge (portfolio excerpt)
//
//  "Circle the wrong thing": the player draws a freehand loop with a finger
//  (captured via a SwiftUI DragGesture into an array of CGPoint). This file is
//  the interesting part — turning that raw scribble into a yes/no answer:
//  "did the user actually CIRCLE the target area?"
//
//  The algorithm is purely geometric (no ML):
//    1. normalize the stroke into the image's 0...1 space (aspect-fit aware)
//    2. measure its bounding box → reject if too small or not roundish
//    3. check the loop is CLOSED (start point near end point)
//    4. check the loop is CENTERED on the target area
//

import CoreGraphics

// MARK: - Models

struct Level: Identifiable {
    let id = UUID()
    let imageName: String

    /// "Wrong" areas in normalized coordinates (0...1) relative to the image (aspect-fit)
    let wrongAreas: [CGRect]

    /// If true the player must circle ALL areas; if false the first one is enough
    let mustFindAll: Bool
}

struct Stroke: Identifiable {
    let id = UUID()
    var points: [CGPoint] = []
}

// MARK: - Detector

enum CircleDetector {

    /// Checks a finished stroke against all not-yet-found areas.
    /// Returns true if this stroke circled at least one new area, and inserts
    /// the matched indices into `foundAreas`.
    static func validate(
        stroke: Stroke,
        imageRect: CGRect,
        wrongAreas: [CGRect],
        mustFindAll: Bool,
        foundAreas: inout Set<Int>
    ) -> Bool {
        var foundThisStroke = false

        for (idx, area) in wrongAreas.enumerated() {
            if foundAreas.contains(idx) { continue }

            let circled = isAreaCircled(
                stroke: stroke,
                imageRect: imageRect,
                targetArea: area,
                minSizeNorm: 0.08,
                closeDistance: 0.14
            )

            if circled {
                foundAreas.insert(idx)
                foundThisStroke = true
                if !mustFindAll { return true }
            }
        }

        return foundThisStroke
    }

    /// The core check: is `stroke` a closed-ish loop drawn around `targetArea`?
    static func isAreaCircled(
        stroke: Stroke,
        imageRect: CGRect,
        targetArea: CGRect,
        minSizeNorm: CGFloat,
        closeDistance: CGFloat
    ) -> Bool {
        guard stroke.points.count > 8 else { return false }

        // 1. Normalize screen points into the image's 0...1 space.
        let normPts: [CGPoint] = stroke.points.compactMap { p in
            guard imageRect.width > 0, imageRect.height > 0 else { return nil }
            return CGPoint(
                x: (p.x - imageRect.minX) / imageRect.width,
                y: (p.y - imageRect.minY) / imageRect.height
            )
        }
        guard normPts.count > 8 else { return false }

        let xs = normPts.map { $0.x }
        let ys = normPts.map { $0.y }

        guard let minX = xs.min(), let maxX = xs.max(),
              let minY = ys.min(), let maxY = ys.max() else { return false }

        let w = maxX - minX
        let h = maxY - minY

        // 2a. Minimum size — ignore tiny accidental taps.
        if w < minSizeNorm || h < minSizeNorm { return false }

        // 2b. Roundish shape — reject very elongated scribbles.
        let ratio = max(w, h) / max(0.0001, min(w, h))
        if ratio > 1.8 { return false }

        // 3. Closed loop — start and end must be near each other.
        let start = normPts.first!
        let end = normPts.last!
        let dist = hypot(start.x - end.x, start.y - end.y)
        if dist > closeDistance { return false }

        // 4. Centered on the target — the loop's center must be near the area's center.
        let center = CGPoint(x: (minX + maxX) / 2, y: (minY + maxY) / 2)
        let targetCenter = CGPoint(x: targetArea.midX, y: targetArea.midY)
        let centerDist = hypot(center.x - targetCenter.x, center.y - targetCenter.y)

        return centerDist < 0.18
    }

    /// Maps the image's aspect-fit rectangle inside its container, so the
    /// detector works in the same coordinate space the image is drawn in.
    static func aspectFitRect(imageSize: CGSize, in containerSize: CGSize) -> CGRect {
        guard imageSize.width > 0, imageSize.height > 0 else {
            return CGRect(origin: .zero, size: containerSize)
        }

        let scale = min(containerSize.width / imageSize.width, containerSize.height / imageSize.height)
        let scaled = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)

        let origin = CGPoint(
            x: (containerSize.width - scaled.width) / 2,
            y: (containerSize.height - scaled.height) / 2
        )

        return CGRect(origin: origin, size: scaled)
    }
}
