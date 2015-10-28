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
    
    var target : ActorNode? = nil
    var aiStateMachine : GKStateMachine = GKStateMachine(states: [])
    
    
    init(target : ActorNode?) {
        super.init()
        actorSprite.texture = spriteSheet.getSprite(3, 2)
        actorBody.categoryBitMask = BodyType.enemy.rawValue
        actorBody.contactTestBitMask = BodyType.player.rawValue | BodyType.ground.rawValue
        
        aiStateMachine = GKStateMachine(states: [PatrollingState(actor: self), AlertedState(actor: self)])
        aiStateMachine.enterState(PatrollingState)
        self.target = target
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        aiStateMachine.updateWithDeltaTime(seconds)
        
    }
    
    override func didBeginContact(otherBody: SKPhysicsBody, contact: SKPhysicsContact) {
        
        switch(otherBody.categoryBitMask){
        case BodyType.ground.rawValue:
            print("Touched the ground")
            if contact.contactNormal.dy > CGFloat(0.8) {
                self.isGrounded = true
            }
        case BodyType.laser.rawValue:
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
    
    func isFacingTarget() -> Bool {
        if let targetX = target?.position.x {
            let myX = self.position.x
            
            if self.isFacingRight {
                return myX < targetX
            }else {
                return myX > targetX
            }
        }
        
        return false
    }
    
    func isTargetInSight() -> Bool {
        if let body = self.scene?.physicsWorld.bodyAlongRayStart(self.position, end: (target?.position)!) {
            if let node = body.node as? ActorNode {
                return node === target!
            }
        }
        
        return false
    }
    
    
    
    /* Garbage */
    required init?(coder aDecoder: NSCoder) {
        super.init()
        actorSprite.texture = spriteSheet.getSprite(3, 2)
        actorBody.categoryBitMask = BodyType.enemy.rawValue
        actorBody.contactTestBitMask = BodyType.player.rawValue | BodyType.ground.rawValue
    }
}