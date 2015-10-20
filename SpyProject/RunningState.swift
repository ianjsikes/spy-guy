//
//  RunningState.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/10/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class RunningState: GKState {
    let actor : ActorNode
    let runningAnimation : [SKTexture]
    var speed : CGFloat = 0.2
    var maxSpeed : CGFloat = 5.0
    
    init(actor: ActorNode, animation: [SKTexture]){
        self.actor = actor
        self.runningAnimation = animation
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if actor.stateDebug {
            print("Entering Running State")
        }
        
        //Plays the running animation when the actor starts to run
        self.actor.actorSprite.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(runningAnimation,
                                                                                        timePerFrame: 0.08,
                                                                                        resize: false,
                                                                                        restore: true)))
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if actor.stateDebug {
            print("Exiting Running State")
        }
        
        //Removes the running animation when the actor stops running
        self.actor.actorSprite.removeAllActions()
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        //Adds to the actor's velocity to make him move
        if !actor.isFacingRight {
            actor.actorVelocity.dx -= speed
        } else {
            actor.actorVelocity.dx += speed
        }
        actor.actorVelocity.dx = max(-maxSpeed, min(maxSpeed, actor.actorVelocity.dx))
        
    }
}