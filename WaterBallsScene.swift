//
//  WaterBallsScene.swift
//  Droppie — Swift Student Challenge (portfolio excerpt)
//
//  Each ball = 1 liter of water. A SpriteKit physics scene spawns the balls
//  over time; they fall with gravity and bounce off the walls and each other.
//  A live counter shows how many liters have dropped. The scene is embedded
//  into SwiftUI through `SpriteView` (see `FallingBallsView` at the bottom).
//

import SwiftUI
import SpriteKit
import UIKit

// MARK: - SpriteKit Scene (Physics Balls)

final class WaterBallsScene: SKScene {
    var ballCount: Int = 0

    private var spawned = 0
    private var spawnAccumulator: TimeInterval = 0
    private let spawnEvery: TimeInterval = 0.02

    // Bigger balls read better on screen
    private let ballRadius: CGFloat = 26

    private let waterUIColor = UIColor(red: 0/255, green: 119/255, blue: 182/255, alpha: 1)

    private let counterLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private let subtitleLabel = SKLabelNode(fontNamed: "AvenirNext-DemiBold")
    private let cardNode = SKShapeNode()

    private var ballTexture: SKTexture?

    override func didMove(to view: SKView) {
        backgroundColor = .white
        anchorPoint = CGPoint(x: 0, y: 0)

        physicsWorld.gravity = CGVector(dx: 0, dy: -18)
        ballTexture = makeBallTexture(radius: ballRadius, color: waterUIColor)

        setupCounterCard()
        rebuildEdges()
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        rebuildEdges()
    }

    // Walls: an edge loop around the whole scene so balls bounce inside it.
    private func rebuildEdges() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: .zero, size: size))
        physicsBody?.restitution = 0.25
        physicsBody?.friction = 0.7
    }

    private func setupCounterCard() {
        let cardSize = CGSize(width: min(size.width * 0.70, 360), height: 170)
        let rect = CGRect(x: -cardSize.width/2, y: -cardSize.height/2, width: cardSize.width, height: cardSize.height)

        cardNode.path = UIBezierPath(roundedRect: rect, cornerRadius: 22).cgPath
        cardNode.fillColor = UIColor.white.withAlphaComponent(0.92)
        cardNode.strokeColor = UIColor.black.withAlphaComponent(0.06)
        cardNode.lineWidth = 1
        cardNode.zPosition = 1000
        cardNode.position = CGPoint(x: size.width/2, y: size.height/2)

        // Fake shadow behind the card
        let shadow = SKShapeNode(path: cardNode.path!)
        shadow.fillColor = UIColor.black.withAlphaComponent(0.10)
        shadow.strokeColor = .clear
        shadow.zPosition = 999
        shadow.position = CGPoint(x: cardNode.position.x, y: cardNode.position.y - 6)
        addChild(shadow)

        counterLabel.text = "0"
        counterLabel.fontSize = 76
        counterLabel.fontColor = waterUIColor
        counterLabel.verticalAlignmentMode = .center
        counterLabel.horizontalAlignmentMode = .center
        counterLabel.position = CGPoint(x: 0, y: 20)

        subtitleLabel.text = "litri d'acqua"
        subtitleLabel.fontSize = 26
        subtitleLabel.fontColor = waterUIColor
        subtitleLabel.verticalAlignmentMode = .center
        subtitleLabel.horizontalAlignmentMode = .center
        subtitleLabel.position = CGPoint(x: 0, y: -50)

        cardNode.addChild(counterLabel)
        cardNode.addChild(subtitleLabel)
        addChild(cardNode)
    }

    // Spawn the balls gradually (a few per frame) instead of all at once.
    override func update(_ currentTime: TimeInterval) {
        if spawned < ballCount {
            spawnAccumulator += 1.0 / 60.0
            while spawnAccumulator >= spawnEvery && spawned < ballCount {
                spawnAccumulator -= spawnEvery
                spawnBall()
                spawned += 1
                counterLabel.text = "\(spawned)"
            }
        }
    }

    private func spawnBall() {
        let r = ballRadius
        let x = CGFloat.random(in: (r + 10)...(size.width - r - 10))
        let y = size.height - r - 2

        let ball: SKSpriteNode
        if let tex = ballTexture {
            ball = SKSpriteNode(texture: tex)
            ball.size = CGSize(width: r * 2, height: r * 2)
        } else {
            ball = SKSpriteNode(color: waterUIColor, size: CGSize(width: r*2, height: r*2))
        }

        ball.name = "ball"
        ball.position = CGPoint(x: x, y: y)
        ball.zPosition = 10

        let body = SKPhysicsBody(circleOfRadius: r)
        body.restitution = 0.25
        body.friction = 0.35
        body.linearDamping = 0.15
        body.angularDamping = 0.25
        body.allowsRotation = true
        body.usesPreciseCollisionDetection = false
        body.velocity = CGVector(dx: CGFloat.random(in: -90...90), dy: 0)

        ball.physicsBody = body
        addChild(ball)
    }

    // Draw the ball texture once with Core Graphics (fill + a soft highlight).
    private func makeBallTexture(radius: CGFloat, color: UIColor) -> SKTexture {
        let size = CGSize(width: radius * 2, height: radius * 2)
        let renderer = UIGraphicsImageRenderer(size: size)
        let img = renderer.image { ctx in
            let rect = CGRect(origin: .zero, size: size)

            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.fillEllipse(in: rect)

            ctx.cgContext.setFillColor(UIColor.white.withAlphaComponent(0.25).cgColor)
            let hRect = CGRect(x: radius*0.25, y: radius*1.05, width: radius*0.9, height: radius*0.55)
            ctx.cgContext.fillEllipse(in: hRect)
        }
        return SKTexture(image: img)
    }
}

// MARK: - Falling Balls View (SwiftUI + SpriteView bridge)

struct FallingBallsView: View {
    let ballCount: Int
    let sceneID: UUID

    var body: some View {
        GeometryReader { geo in
            let h = UIScreen.main.bounds.height
            let size = CGSize(width: geo.size.width, height: h)

            SpriteView(scene: makeScene(size: size), options: [.ignoresSiblingOrder])
                .id(sceneID)
                .frame(width: size.width, height: size.height)
                .ignoresSafeArea()
        }
    }

    private func makeScene(size: CGSize) -> SKScene {
        let scene = WaterBallsScene()
        scene.size = size
        scene.scaleMode = .resizeFill
        scene.ballCount = ballCount
        return scene
    }
}
