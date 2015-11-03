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
    var enemyLeft = true
    var enemyRight = false
    var enemyPosition:CGFloat = 0
//    var runningEnemyTextures = [SKTexture]()
    
    init(actor: EnemyNode){
        self.actor = actor
        enemyPosition = actor.position.x
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
    
    func updateEnemyPosition() {
        
        if enemyLeft == true {
            
            actor.setFacingRight(false)
            
            self.actor.position.x -= 2
            
            if self.actor.position.x < enemyPosition - 50  {
                
                self.actor.position.x = enemyPosition - 50
                
                enemyLeft = false
                
                enemyRight = true
                
            }
        }
        
        if enemyRight == true {
            
            actor.setFacingRight(true)
            
            self.actor.position.x += 2
            
            if self.actor.position.x > enemyPosition + 50 {
                
                self.actor.position.x = enemyPosition + 50
                
                enemyRight = false
                
                enemyLeft = true
            }
        }
    }

    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        
        
        updateEnemyPosition()
        
//        if actor.isFacingTarget() {
//            if actor.isTargetInSight() {
//                self.stateMachine?.enterState(AlertedState)
//            }
//        }
    }
    
}
