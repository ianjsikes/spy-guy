//
//  IdleState.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/10/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class IdleState: GKState {
    let player : PlayerNode
    let deccelerationFactor : CGFloat = 0.65
    
    init(player: PlayerNode){
        self.player = player
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if player.stateDebug {
            print("Entering Idle State")
        }
        
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if player.stateDebug {
            print("Exiting Idle State")
        }
        
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        //Slows the player down
        player.pVelocity.dx *= deccelerationFactor
    }
    
}