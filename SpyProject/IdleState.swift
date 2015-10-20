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
    let actor : ActorNode
    let deccelerationFactor : CGFloat = 0.65
    
    init(actor: ActorNode){
        self.actor = actor
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if actor.stateDebug {
            print("Entering Idle State")
        }
        
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if actor.stateDebug {
            print("Exiting Idle State")
        }
        
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        //Slows the actor down
        actor.actorVelocity.dx *= deccelerationFactor
    }
    
}