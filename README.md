# Droppie — Swift Student Challenge

> A playful iOS app about **saving water**. Every interaction is a tiny game that makes
> the message tangible. Built for the **Swift Student Challenge**.

This repo is a **portfolio excerpt**: three of the most interesting interaction techniques,
not the whole app.

---

## 1. Water balls with real physics 💧 (`WaterBallsScene.swift`)

Each ball = **1 liter of water**. A **SpriteKit** scene drops the balls over time; they fall
with gravity and bounce off the walls and each other while a live counter ticks up.
It's bridged into SwiftUI with `SpriteView`.

- `physicsWorld.gravity` + an `edgeLoop` body for the walls
- per-ball `SKPhysicsBody(circleOfRadius:)` with `restitution` / `friction` / `damping`
- gradual spawning inside `update(_:)` (a few balls per frame, not all at once)
- the ball texture is drawn once with **Core Graphics** (fill + soft highlight)
- **SpriteKit ↔ SwiftUI** bridge via `SpriteView` (`FallingBallsView`)

## 2. "Circle the wrong thing" gesture detection (`CircleDetection.swift`)

The player draws a freehand loop with a finger (a `DragGesture` collecting `CGPoint`s, drawn
with `Canvas`). The interesting part is deciding **"did they actually circle the target?"** —
a small, purely geometric recognizer (no ML):

1. normalize the stroke into the image's 0...1 space (aspect-fit aware)
2. reject if the bounding box is too small or too elongated to be a circle
3. require a **closed loop** (start point near end point)
4. require the loop to be **centered** on the target area

## 3. Animated mascot "Gocciolina" (`GocciolinaAnimatedView.swift`)

The water-drop mascot that guides the player:

- idle **floating** loop + a press reaction (`DragGesture`) with **haptics** (`sensoryFeedback`)
- **mouth animation synced to speech**: a `Timer` toggles open/closed SVG while `isSpeaking`
- vector art rendered from inline **SVG** via a `WKWebView` (`UIViewRepresentable`)
- a soft, dynamic drop shadow that reacts to the float height

---

## Skills shown

SpriteKit physics · SpriteKit↔SwiftUI bridging · Core Graphics texture drawing ·
SwiftUI gestures (`DragGesture`, `Canvas`) · geometric gesture recognition · `Timer`-driven
animation · haptics · `UIViewRepresentable` / `WKWebView` · MVVM-ish state with `@State` / `@Binding`.

---

*Built with Swift, SwiftUI, SpriteKit · Swift Student Challenge project.*
