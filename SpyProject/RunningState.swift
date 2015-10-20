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
    let player : PlayerNode
    let runningAnimation : [SKTexture]
    var speed : CGFloat = 0.2
    var maxSpeed : CGFloat = 5.0
    
    init(player: PlayerNode, animation: [SKTexture]){
        self.player = player
        self.runningAnimation = animation
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if player.stateDebug {
            print("Entering Running State")
        }
        
        //Plays the running animation when the player starts to run
        self.player.pSprite.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(runningAnimation,
                                                                                        timePerFrame: 0.08,
                                                                                        resize: false,
                                                                                        restore: true)))
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if player.stateDebug {
            print("Exiting Running State")
        }
        
        //Removes the running animation when the player stops running
        self.player.pSprite.removeAllActions()
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        //Adds to the player's velocity to make him move
        if !player.isFacingRight {
            player.pVelocity.dx -= speed
        } else {
            player.pVelocity.dx += speed
        }
        player.pVelocity.dx = max(-maxSpeed, min(maxSpeed, player.pVelocity.dx))
        
    }
}