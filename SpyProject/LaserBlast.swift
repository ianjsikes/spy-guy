//
//  LaserBlast.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/25/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import SpriteKit

class LaserBlast : SKSpriteNode, CollisionHandler {
    
    enum Direction : Int {
        case Left = -1
        case Right = 1
    }
    
    let xDirection : Int
    let velocity : CGFloat
    
    init(dir : Direction, velocity : CGFloat, pos : CGPoint) {
        self.xDirection = dir.rawValue
        self.velocity = velocity
        
        let tex = SKTexture(imageNamed: "laser-blast")
        let body = SKPhysicsBody(rectangleOfSize: tex.size())
        body.affectedByGravity = false
        body.allowsRotation = false
        body.categoryBitMask = BodyType.laser.rawValue
        body.contactTestBitMask = BodyType.enemy.rawValue | BodyType.ground.rawValue
        body.collisionBitMask = UInt32(0)
        
        super.init(texture: tex, color: UIColor.whiteColor(), size: tex.size())
        self.physicsBody = body
        self.position = pos
        
        self.runAction(SKAction.repeatActionForever(SKAction.moveByX(velocity * CGFloat(xDirection), y: 0.0, duration: 0.1)))
    }
    
    func didBeginContact(otherBody: SKPhysicsBody, contact: SKPhysicsContact) {
        switch(otherBody.categoryBitMask){
        case BodyType.enemy.rawValue:
            self.runAction(SKAction.removeFromParent())
        case BodyType.ground.rawValue:
            self.runAction(SKAction.removeFromParent())
        default:
            return
        }
    }
    
    func didEndContact(otherBody: SKPhysicsBody, contact: SKPhysicsContact) {
        return
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}