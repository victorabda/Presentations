//
//  GameScene.swift
//  CocoaSwift
//
//  Created by Victor Augusto Borges Dias de Almeida on 29/06/15.
//  Copyright (c) 2015 VictorAlmeida. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var gameState: Int = 0
    
    // MARK: - Initialization
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.blackColor()
        example1()
    }

    
    // MARK: - Example 1 (floor and balls)
    func example1() {
        gameState = 1
        self.addChild(self.createFloor())
        physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
    }
    
    func createFloor() -> SKSpriteNode {
        
        // Cria uma imagem retangular e marrom para representar o chão
        let floor = SKSpriteNode(color: SKColor.brownColor(), size: CGSizeMake(self.frame.size.width, 20))
        floor.anchorPoint = CGPointMake(0, 0)
        floor.name = "floor"
        
        // Adiciona um corpo de física do tamanho da imagem
        floor.physicsBody = SKPhysicsBody(edgeLoopFromRect: floor.frame)
        floor.physicsBody?.dynamic = false
    
        return floor
    }
    
    func createBall(position: CGPoint) -> SKShapeNode {
        
        // Cria uma forma circular no local que recebeu o toque
        let ball = SKShapeNode(circleOfRadius: 20.0)
        ball.fillColor = SKColor(red: CGFloat(arc4random() % 256) / 256.0, green: CGFloat(arc4random() % 256) / 256.0, blue: CGFloat(arc4random() % 256) / 256.0, alpha: 1.0)
        ball.position = position
        ball.name = "ball"
        
        // Adiciona um corpo de física para a bola
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20.0)
        ball.physicsBody?.dynamic = true

        // Quantidade de energia que é devolvida a bola ao pingar
        ball.physicsBody?.restitution = 0.5
        
        // Cria uma esfera dentro da bola para marcar a posição
        let positionMark = SKShapeNode(circleOfRadius: 6.0)
        positionMark.fillColor = SKColor.blackColor()
        positionMark.position.y = -12
        ball.addChild(positionMark)
        
        return ball
    }


    // MARK: - Touch events
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

        for touch: AnyObject in touches {
            let location:CGPoint = touch.locationInNode(self)
            let floor:SKNode? = self.childNodeWithName("floor")
            if floor?.containsPoint(location) != nil {
                self.addChild(self.createBall(location))
            }
        }
    }
   
    // MARK: - Update
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func didSimulatePhysics() {
        self.enumerateChildNodesWithName("ball", usingBlock: { (node: SKNode!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            if node.position.y < 20 {
                node.removeFromParent()
            }
        })
    }

}
