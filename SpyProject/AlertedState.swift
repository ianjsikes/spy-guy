//
//  AlertedState.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/27/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class AlertedState: GKState {
    let actor : EnemyNode
    let alertedIcon : SKSpriteNode
    
    init(actor: EnemyNode){
        
        self.actor = actor
        alertedIcon = SKSpriteNode(imageNamed: "alerted-icon")
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if actor.stateDebug {
            print("Entering \(self.dynamicType)")
        }
        
        actor.addChild(alertedIcon)
        alertedIcon.position.y = CGFloat(50)
        
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if actor.stateDebug {
            print("Exiting \(self.dynamicType)")
        }
        
        alertedIcon.removeFromParent()
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        if !actor.isFacingTarget() || !actor.isTargetInSight() {
            self.stateMachine?.enterState(PatrollingState)
        }
    }
    
}