//
//  JumpingState.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/25/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class JumpingState: GKState {
    let actor : ActorNode
    let deccelerationFactor : CGFloat = 0.65
    let runningAnimation : [SKTexture]
    var speed : CGFloat = 0.2
    var maxSpeed : CGFloat = 5.0
    
    init(actor: ActorNode, animation: [SKTexture]){
        self.actor = actor
        self.runningAnimation = animation
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if actor.stateDebug {
            print("Entering \(self.dynamicType)")
        }
        
        actor.actorBody.applyImpulse(CGVector(dx: 0.0, dy: 200.0))
        actor.isGrounded = false
        
        //Plays the running animation when the actor starts to run
        self.actor.actorSprite.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(runningAnimation,
            timePerFrame: 0.08,
            resize: false,
            restore: true)))
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if actor.stateDebug {
            print("Exiting \(self.dynamicType)")
        }
        
        actor.isGrounded = true
        
        //Removes the running animation when the actor stops running
        self.actor.actorSprite.removeAllActions()
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        //Slows the actor down
        actor.actorVelocity.dx *= deccelerationFactor
        
        //Adds to the actor's velocity to make him move
        if !actor.isFacingRight {
            actor.actorVelocity.dx -= speed
        } else {
            actor.actorVelocity.dx += speed
        }
        actor.actorVelocity.dx = max(-maxSpeed, min(maxSpeed, actor.actorVelocity.dx))
    }
    
}