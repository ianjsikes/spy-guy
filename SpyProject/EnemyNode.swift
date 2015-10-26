//
//  EnemyNode.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/19/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EnemyNode: ActorNode {
    
    override init() {
        super.init()
        actorSprite.texture = spriteSheet.getSprite(3, 2)
        actorBody.categoryBitMask = BodyType.enemy.rawValue
        actorBody.contactTestBitMask = BodyType.player.rawValue | BodyType.ground.rawValue
    }
    
    override func didBeginContact(otherBody: SKPhysicsBody, contact: SKPhysicsContact) {
        
        switch(otherBody.categoryBitMask){
        case BodyType.ground.rawValue:
            print("Touched the ground")
            if contact.contactNormal.dy > CGFloat(0.8) {
                self.isGrounded = true
            }
        case BodyType.laser.rawValue:
            otherBody.node?.runAction(SKAction.removeFromParent())
            self.runAction(SKAction.removeFromParent())
        default:
            return
        }
        
    }
    override func didEndContact(otherBody: SKPhysicsBody, contact: SKPhysicsContact) {
        
        switch(otherBody.categoryBitMask){
        case BodyType.ground.rawValue:
            print("Left the ground")
        default:
            return
        }
    }
    
    
    
    
    
    /* Garbage */
    required init?(coder aDecoder: NSCoder) {
        super.init()
        actorSprite.texture = spriteSheet.getSprite(3, 2)
        actorBody.categoryBitMask = BodyType.enemy.rawValue
        actorBody.contactTestBitMask = BodyType.player.rawValue | BodyType.ground.rawValue
    }
}