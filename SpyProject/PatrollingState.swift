//
//  PatrollingState.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/27/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class PatrollingState: GKState {
    let actor : EnemyNode
    
    init(actor: EnemyNode){
        self.actor = actor
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if actor.stateDebug {
            print("Entering \(self.dynamicType)")
        }
        
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if actor.stateDebug {
            print("Exiting \(self.dynamicType)")
        }
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        
        if actor.isFacingTarget() {
            if actor.isTargetInSight() {
                self.stateMachine?.enterState(AlertedState)
            }
        }
    }
    
}
